defmodule Parser do
  @moduledoc """
  This is the base Parser module. 
  It acts as the initial point of contact for all incoming commands and passes control to the appropriate module.
  """

  def parse(command) do
    IO.puts(command)
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
    case Parser.Registry.lookup(curr) do
      nil -> Parser.Literal
      parser -> parser
    end
  end
end
