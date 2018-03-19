defmodule Mu.Parser.Behaviour do
  @doc "Returns the list of of commands implemented by this parser module"
  @callback commands() :: map
end
