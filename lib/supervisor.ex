defmodule Mu.Supervisor do
  use Supervisor
  require Mu.Monitor
  require Mu.Parser.Registry

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init(_) do
    children = [
      worker(Mu.Parser.Registry, []),
      Mu.Monitor
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
