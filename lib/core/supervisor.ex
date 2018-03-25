defmodule Mu.Core.Supervisor do
  use Supervisor
  require Mu.Core.Monitor
  require Mu.Core.ParserRegistry

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init(_) do
    children = [
      # {Mu.Core.ParserRegistry, name: Mu.Core.ParserRegistry},
      {Mu.Core.ParserRegistry, []},
      {Task.Supervisor, name: Mu.Core.Monitor.TaskSupervisor},
      {Mu.Core.Monitor, name: Mu.Core.Monitor}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
