defmodule Parser.Literal do
  def parse(command, tail) do
    IO.puts("Literal: #{command}")
    SystemInput.string("good morning")
    tail
  end
end
