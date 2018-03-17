defmodule Parser.Supervisor do
  require Parser.Registry
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init(_) do
    children = [
      worker(Parser.Registry, [])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
