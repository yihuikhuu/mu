defmodule Mu.Commands.Format do
  require Logger
  alias Mu.Core.System.Input, as: Input

  @behaviour Mu.Core.CommandBehaviour
  @moduledoc """
  This parser module handles commands specific to string formatting for coding purposes
  """

  @commands %{
    "snik" => %{
      :description => "Write text in snake case",
      :function => :snake_case,
      :grammar => :text
    },
    "coni" => %{
      :description => "Write text in constant case",
      :function => :constant_case,
      :grammar => :text
    },
    "cami" => %{
      :description => "Write text in camel case",
      :function => :camel_case,
      :grammar => :text
    },
    "scali" => %{
      :description => "Write text in pascal case",
      :function => :pascal_case,
      :grammar => :text
    },
    "skewi" => %{
      :description => "Write text in dash case",
      :function => :dash_case,
      :grammar => :text
    },
    "dotsi" => %{
      :description => "Write text in dot case",
      :function => :dot_case,
      :grammar => :text
    },
    "pathi" => %{
      :description => "Write text in path case",
      :function => :path_case,
      :grammar => :text
    }
  }

  def commands() do
    @commands
  end

  def snake_case(text \\ nil) do
    if text do
      Recase.to_snake(text)
      |> Input.string()
    end
  end

  def constant_case(text \\ nil) do
    if text do
      Recase.to_constant(text)
      |> Input.string()
    end
  end

  def camel_case(text \\ nil) do
    if text do
      Recase.to_camel(text)
      |> Input.string()
    end
  end

  def pascal_case(text \\ nil) do
    if text do
      Recase.to_pascal(text)
      |> Input.string()
    end
  end

  def dash_case(text \\ nil) do
    if text do
      Recase.to_kebab(text)
      |> String.split("", trim: true)
      |> Enum.reduce([], fn x, acc -> acc ++ [String.to_existing_atom(x)] end)
      |> Input.key_list()
    end
  end

  def dot_case(text \\ nil) do
    if text do
      Recase.to_dot(text)
      |> String.split("", trim: true)
      |> Enum.reduce([], fn x, acc -> acc ++ [String.to_existing_atom(x)] end)
      |> Input.key_list()
    end
  end

  def path_case(text \\ nil) do
    if text do
      Recase.to_path(text)
      |> Input.string()
    end
  end
end
