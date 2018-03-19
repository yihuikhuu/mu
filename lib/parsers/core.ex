defmodule Mu.Parser.Core do
  @behaviour Mu.Parser.Behaviour
  @moduledoc """
  This parser module contains core functionality that is applicable to all applications 
  """

  @commands %{}

  def commands() do
    @commands
  end
end
