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
    },
    "douhao" => %{
      :description => "comma",
      :module => __MODULE__,
      :function => :comma,
      :grammar => :action
    },
    "shi" => %{
      :description => "equal",
      :module => __MODULE__,
      :function => :equal,
      :grammar => :action
    },
    "dengyu" => %{
      :description => "double equal",
      :module => __MODULE__,
      :function => :double_equal,
      :grammar => :action
    },
    "yandengyu" => %{
      :description => "triple equal",
      :module => __MODULE__,
      :function => :triple_equal,
      :grammar => :action
    },
    "xiaoping" => %{
      :description => "less than or equal",
      :module => __MODULE__,
      :function => :less_than_equal,
      :grammar => :action
    },
    "daping" => %{
      :description => "greater than or equal",
      :module => __MODULE__,
      :function => :greater_than_equal,
      :grammar => :action
    },
    "xiaoguo" => %{
      :description => "less than",
      :module => __MODULE__,
      :function => :less_than,
      :grammar => :action
    },
    "daguo" => %{
      :description => "greater than",
      :module => __MODULE__,
      :function => :greater_than,
      :grammar => :action
    },
    "maohao" => %{
      :description => "colon",
      :module => __MODULE__,
      :function => :colon,
      :grammar => :action
    },
    "fenhao" => %{
      :description => "semi colon",
      :module => __MODULE__,
      :function => :semicolon,
      :grammar => :action
    },
    "wenhao" => %{
      :description => "question mark",
      :module => __MODULE__,
      :function => :question_mark,
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

  # Helper function for handling standard escape/input/move/exit procedure
  def sequence(keys) do
    Input.key_list([:escape, :a] ++ keys ++ [:left, :escape])
  end

  def brackets do
    Input.key_list([:"(", :")", :left])
  end

  def braces do
    Input.key_list([:"{", :"}", :left])
  end

  def square_brackets do
    Input.key_list([:"[", :"]", :left])
  end

  def dot do
    Input.key_list([:.])
  end

  def comma do
    Input.key_list([:","])
  end

  def equal do
    Input.key_list([:space, :=, :space])
  end

  def double_equal do
    Input.key_list([:space, :=, :=, :space])
  end

  def triple_equal do
    Input.key_list([:space, :=, :=, :=, :space])
  end

  def less_than_equal do
    Input.key_list([:space, :<, :=, :space])
  end

  def greater_than_equal do
    Input.key_list([:space, :>, :=, :space])
  end

  def less_than do
    Input.key_list([:space, :<, :space])
  end

  def greater_than do
    Input.key_list([:space, :>, :space])
  end

  def colon do
    Input.key_list([:":"])
  end

  def semicolon do
    Input.key_list([:";"])
  end

  def question_mark do
    Input.key_list([:space, :"?", :space])
  end
end
