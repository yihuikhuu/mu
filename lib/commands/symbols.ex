defmodule Mu.Commands.Symbols do
  require Logger
  alias Mu.Core.System.Input, as: Input

  @behaviour Mu.Core.CommandBehaviour
  @moduledoc """
  This parser module handles commands specific to symbols used while coding
  """

  @commands %{
    "kong" => %{
      :description => "space",
      :module => __MODULE__,
      :function => :space,
      :grammar => :single
    },
    "hang" => %{
      :description => "line break",
      :module => __MODULE__,
      :function => :line_break,
      :grammar => :single
    },
    "biao" => %{
      :description => "tab",
      :module => __MODULE__,
      :function => :tab,
      :grammar => :single
    },
    "yuan" => %{
      :description => "brackets",
      :module => __MODULE__,
      :function => :brackets,
      :grammar => :single
    },
    "hua" => %{
      :description => "braces",
      :module => __MODULE__,
      :function => :braces,
      :grammar => :single
    },
    "fang" => %{
      :description => "square brackets",
      :module => __MODULE__,
      :function => :square_brackets,
      :grammar => :single
    },
    "dian" => %{
      :description => "dot",
      :module => __MODULE__,
      :function => :dot,
      :grammar => :single
    }
  }

  def commands() do
    @commands
  end

  def space do
    Input.key(:escape)
    Input.key(:a)
    Input.key(:space)
  end

  def line_break do
    Input.key(:escape)
    Input.key(:a)
    Input.key(:enter)
  end

  def brackets do
    Input.key(:escape)
    Input.key(:a)
    Input.string("()")
    Input.key(:left)
  end

  def braces do
    Input.key(:escape)
    Input.key(:a)
    Input.string("{}")
    Input.key(:left)
  end

  def square_brackets do
    Input.key(:escape)
    Input.key(:a)
    Input.string("[]")
    Input.key(:left)
  end

  def dot do
    Input.key(:escape)
    Input.key(:a)
    Input.string(".")
    Input.key(:left)
  end
end
