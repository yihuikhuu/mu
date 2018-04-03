defmodule Mu.Commands.Literal do
  require Logger
  alias Mu.Core.System.Input, as: Input

  @behaviour Mu.Core.CommandBehaviour
  @moduledoc """
  This parser module contains basic literal functionality, i.e. literal transcription of commands.
  """

  @commands %{
    "liti" => %{
      :function => :literal,
      :grammar => :unconstrained
    },
    "cap" => %{
      :function => :capitalise,
      :grammar => :single
    }
  }

  def commands do
    @commands
  end

  def literal(text \\ nil) do
    if text do
      Input.string(text)
    end
  end

  def capitalise(text \\ nil) do
    if text do
      String.capitalize(text)
      |> Input.string()
    end
  end
end
