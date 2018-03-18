defmodule Parser.Literal do
  require Logger
  @behaviour Parser.Behaviour
  @moduledoc """
  This parser module contains basic literal functionality, i.e. literal transcription of commands.
  """

  @commands %{
    "liu" => %{
      :description => "Keep following text",
      :module => __MODULE__,
      :function => :literal,
      :grammar => :unconstrained
    }
  }

  def parse(command, tail) do
    Logger.info("Literal: #{command}")
    literal(tail)
  end

  def literal(tail) do
    SystemInput.string(tail)
  end
end
