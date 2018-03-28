defmodule Mu.Commands.Literal do
  require Logger
  alias Mu.Core.System.Input, as: Input

  @behaviour Mu.Core.CommandBehaviour
  @moduledoc """
  This parser module contains basic literal functionality, i.e. literal transcription of commands.
  """

  @commands %{
    "chun" => %{
      :description => "Keep following text",
      :module => __MODULE__,
      :function => :literal,
      :grammar => :unconstrained
    }
  }

  def commands() do
    @commands
  end

  def literal(text \\ nil) do
    if text do
      Input.key_list([:escape, :a])
      Input.string(text)
      Input.key(:escape)
    end
  end
end
