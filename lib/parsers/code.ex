defmodule Mu.Parser.Code do
  require Logger
  @behaviour Mu.Parser.Behaviour
  @moduledoc """
  This parser module handles commands specific to coding
  """

  @commands %{
    "sheshi" => %{
      :description => "Write text in snake case",
      :module => __MODULE__,
      :function => :snake_case,
      :grammar => :text
    },
    "changshi" => %{
      :description => "Write text in constant case",
      :module => __MODULE__,
      :function => :constant_case,
      :grammar => :text
    },
    "luoshi" => %{
      :description => "Write text in camel case",
      :module => __MODULE__,
      :function => :camel_case,
      :grammar => :text
    },
    "dashi" => %{
      :description => "Write text in pascal case",
      :module => __MODULE__,
      :function => :pascal_case,
      :grammar => :text
    },
    "lianshi" => %{
      :description => "Write text in dash case",
      :module => __MODULE__,
      :function => :dash_case,
      :grammar => :text
    },
    "dianshi" => %{
      :description => "Write text in dot case",
      :module => __MODULE__,
      :function => :dot_case,
      :grammar => :text
    },
    "lushi" => %{
      :description => "Write text in path case",
      :module => __MODULE__,
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
      |> System.Input.string()
    end
  end

  def constant_case(text \\ nil) do
    if text do
      Recase.to_constant(text)
      |> System.Input.string()
    end
  end

  def camel_case(text \\ nil) do
    if text do
      Recase.to_camel(text)
      |> System.Input.string()
    end
  end

  def pascal_case(text \\ nil) do
    if text do
      Recase.to_pascal(text)
      |> System.Input.string()
    end
  end

  def dash_case(text \\ nil) do
    if text do
      Recase.to_kebab(text)
      |> System.Input.string()
    end
  end

  def dot_case(text \\ nil) do
    if text do
      Recase.to_dot(text)
      |> System.Input.string()
    end
  end

  def path_string(text \\ nil) do
    if text do
      Recase.to_path(text)
      |> System.Input.string()
    end
  end
end
