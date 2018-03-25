defmodule Mu do
  @moduledoc """
  Documentation for Mu.
  """

  def start(_type, _args) do
    Mu.Core.Supervisor.start_link()
  end
end
