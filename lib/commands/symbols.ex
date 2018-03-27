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
      :grammar => :action
    },
    "duanhang" => %{
      :description => "line break",
      :module => __MODULE__,
      :function => :line_break,
      :grammar => :action
    },
    "biao" => %{
      :description => "tab",
      :module => __MODULE__,
      :function => :tab,
      :grammar => :action
    },
    "yuangua" => %{
      :description => "brackets",
      :module => __MODULE__,
      :function => :brackets,
      :grammar => :action
    },
    "huagua" => %{
      :description => "braces",
      :module => __MODULE__,
      :function => :braces,
      :grammar => :action
    },
    "fanggua" => %{
      :description => "square brackets",
      :module => __MODULE__,
      :function => :square_brackets,
      :grammar => :action
    },
    "dian" => %{
      :description => "dot",
      :module => __MODULE__,
      :function => :dot,
      :grammar => :action
    }
  }

  def commands() do
    @commands
  end

  def space do
    Input.key_list([:escape, :a, :space])
  end

  def line_break do
    Input.key_list([:escape, :a, :enter])
  end

  def tab do
    Input.key(:tab)
  end

  def brackets do
    Input.key_list([:escape, :a, :"(", :")", :left])
  end

  def braces do
    Input.key_list([:escape, :a, :"{", :"}", :left])
  end

  def square_brackets do
    Input.key_list([:escape, :a, :"[", :"]", :left])
  end

  def dot do
    Input.key_list([:escape, :a, :., :left])
  end
end
