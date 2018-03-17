defmodule Mu do
  @moduledoc """
  Documentation for Mu.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Mu.hello
      :world

  """
  def start(_type, _args) do
    Mu.Supervisor.start_link()
  end
end
