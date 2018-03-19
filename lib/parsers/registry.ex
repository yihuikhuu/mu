defmodule Mu.Parser.Registry do
  use GenServer
  require Logger

  @doc """
  Starts the registry.
  """
  def start_link do
    GenServer.start_link(__MODULE__, load_parsers(), name: Mu.Parser.Registry)
  end

  def start_link(opts) do
    GenServer.start_link(__MODULE__, load_parsers(), opts)
  end

  def load_parsers do
    {:ok, json} = File.read(Application.app_dir(:mu) <> "/priv/parsers.json")

    Poison.Parser.parse!(json)
    |> Enum.filter(fn x -> x["use"] end)
    |> Enum.reduce(%{}, fn x, acc ->
      Map.merge(apply(String.to_existing_atom("Elixir." <> x["name"]), :commands, []), acc)
    end)
  end

  def lookup(command) do
    GenServer.call(Mu.Parser.Registry, {:lookup, command})
  end

  ## Server Callbacks

  def init(parsers) do
    {:ok, parsers}
  end

  def handle_call({:lookup, command}, _from, parsers) do
    {:reply, Map.get(parsers, command), parsers}
  end
end
