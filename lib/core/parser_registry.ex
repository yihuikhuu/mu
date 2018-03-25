defmodule Mu.Core.ParserRegistry do
  use GenServer
  require Logger

  @doc """
  Starts the registry.
  """
  def start_link(opts) do
    commands = load_commands()
    output_vocabulary(commands)
    GenServer.start_link(__MODULE__, commands, name: Mu.Core.ParserRegistry)
  end

  def output_vocabulary(commands) do
    vocabulary_file_path = Application.app_dir(:mu) <> "/priv/vocabulary.json"

    if not File.exists?(vocabulary_file_path) do
      command_names =
        Enum.reduce(commands, [], fn {k, v}, acc ->
          acc ++ [k]
        end)

      File.write(
        vocabulary_file_path,
        Poison.Encoder.encode(command_names, pretty: true)
      )
    end
  end

  def load_commands do
    Application.get_env(:mu, :command_modules)
    |> Enum.filter(fn x -> Map.has_key?(x, :use) && Map.has_key?(x, :name) && x.use end)
    |> Enum.reduce(%{}, fn x, acc ->
      Map.merge(
        acc,
        apply(String.to_existing_atom("Elixir.Mu.Commands." <> x.name), :commands, [])
      )
    end)
  end

  def lookup(command) do
    GenServer.call(Mu.Core.ParserRegistry, {:lookup, command})
  end

  ## Server Callbacks

  def init(parsers) do
    {:ok, parsers}
  end

  def handle_call({:lookup, command}, _from, parsers) do
    {:reply, Map.get(parsers, command), parsers}
  end
end
