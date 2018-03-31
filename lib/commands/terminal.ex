defmodule Mu.Commands.Terminal do
  require Logger
  alias Mu.Core.System.Input, as: Input

  @behaviour Mu.Core.CommandBehaviour
  @moduledoc """
  This parser module contains functionality specific to the terminal.
  """

  @commands %{
  }

  def commands() do
    @commands
  end

  """
  Required commands:
  Tmux - Start, create window, close window, switch window, split, switch split
  Git - Status, push (Can probably use vim-fugitive)
  Docker - compose start, compose stop
  """

end
