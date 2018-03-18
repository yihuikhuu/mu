defmodule Mu.Parser do
  @moduledoc """
  This is the base Parser module. 
  It acts as the initial point of contact for all incoming commands and passes control to the appropriate module.
  """

  def parse(command) do
    IO.inspect(Process.registered())
    process(command, [])
  end

  def process(command, accumulate) do
    if command do
      String.trim(command, "\n")
      |> String.split(" ", parts: 2)
      |> (fn [curr, tail] -> apply(get_parser(curr), :parse, [curr, tail]) end).()
      |> IO.inspect()
    end
  end

  def get_parser(curr) do
    case Mu.Parser.Registry.lookup(curr) do
      nil -> Mu.Parser.Literal
      parser -> parser
    end
  end
end
