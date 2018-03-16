defmodule Parser do
  def parse(command) do
    IO.puts command
    process(command, [])
  end

  def process(command, accumulate) do
    if command do
      String.trim(command, "\n")
      |> String.split(" ", parts: 2)
      |> fn [curr, rest] -> {get_parser(curr), curr, rest} end.()
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

