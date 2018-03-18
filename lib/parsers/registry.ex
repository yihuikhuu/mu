defmodule Mu.Parser.Registry do
  use GenServer
  require Logger

  @doc """
  Starts the registry.
  """
  def start_link do
    Logger.info(Application.app_dir(:mu))
    GenServer.start_link(__MODULE__, %{}, name: Mu.Parser.Registry)
  end

  def start_link(opts) do
    Logger.info(Application.app_dir(:mu))
    GenServer.start_link(__MODULE__, %{}, opts)
  end

  def load_parsers do
    case File.read("parsers.json") do
      {:ok, json_parsers} -> json_parsers
      {:error, reason} -> %{}
    end
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
