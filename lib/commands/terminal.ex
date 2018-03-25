defmodule Mu.Commands.Terminal do
  require Logger
  alias Mu.Core.System.Input, as: Input

  @behaviour Mu.Core.CommandBehaviour
  @moduledoc """
  This parser module contains functionality specific to the terminal.
  """

  @commands %{}

  def commands() do
    @commands
  end
end
