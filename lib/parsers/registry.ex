defmodule Parser.Registry do
  use GenServer
  @doc """
  Starts the registry.
  """
  def start_link do
    GenServer.start_link(__MODULE__, %{}, name: :parser_registry)
  end

  def lookup(command) do
    GenServer.call(:parser_registry, {:lookup, command})
  end

  ## Server Callbacks

  def init(parsers) do
    {:ok, parsers}
  end

  def handle_call({:lookup, command}, _from, parsers) do
    {:reply, Map.get(parsers, command), parsers}
  end
end
