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
    "blin" => %{
      :description => "line break",
      :module => __MODULE__,
      :function => :line_break,
      :grammar => :action
    },
    "tabi" => %{
      :description => "tab",
      :module => __MODULE__,
      :function => :tab,
      :grammar => :action
    },
    "plex" => %{
      :description => "parenthesis",
      :module => __MODULE__,
      :function => :parenthesis,
      :grammar => :action
    },
    "brex" => %{
      :description => "braces",
      :module => __MODULE__,
      :function => :braces,
      :grammar => :action
    },
    "squex" => %{
      :description => "square brackets",
      :module => __MODULE__,
      :function => :square_brackets,
      :grammar => :action
    },
    "angex" => %{
      :description => "angle brackets",
      :module => __MODULE__,
      :function => :angle_brackets,
      :grammar => :action
    },
    "dotti" => %{
      :description => "dot",
      :module => __MODULE__,
      :function => :dot,
      :grammar => :action
    },
    "kama" => %{
      :description => "comma",
      :module => __MODULE__,
      :function => :comma,
      :grammar => :action
    },
    "quali" => %{
      :description => "equal without pre-space",
      :module => __MODULE__,
      :function => :equal,
      :grammar => :action
    },
    "qualis" => %{
      :description => "equal with pre-space",
      :module => __MODULE__,
      :function => :spaced_equal,
      :grammar => :action
    },
    "dequal" => %{
      :description => "double equal",
      :module => __MODULE__,
      :function => :double_equal,
      :grammar => :action
    },
    "teaqual" => %{
      :description => "triple equal",
      :module => __MODULE__,
      :function => :triple_equal,
      :grammar => :action
    },
    "lani" => %{
      :description => "less than or equal",
      :module => __MODULE__,
      :function => :less_than_equal,
      :grammar => :action
    },
    "gani" => %{
      :description => "greater than or equal",
      :module => __MODULE__,
      :function => :greater_than_equal,
      :grammar => :action
    },
    "lan" => %{
      :description => "less than",
      :module => __MODULE__,
      :function => :less_than,
      :grammar => :action
    },
    "gan" => %{
      :description => "greater than",
      :module => __MODULE__,
      :function => :greater_than,
      :grammar => :action
    },
    "clon" => %{
      :description => "colon",
      :module => __MODULE__,
      :function => :colon,
      :grammar => :action
    },
    "slon" => %{
      :description => "semi colon",
      :module => __MODULE__,
      :function => :semicolon,
      :grammar => :action
    },
    "queso" => %{
      :description => "question mark",
      :module => __MODULE__,
      :function => :question_mark,
      :grammar => :action
    },
    "swote" => %{
      :description => "quote",
      :module => __MODULE__,
      :function => :quote,
      :grammar => :action
    },
    "dwote" => %{
      :description => "double quote",
      :module => __MODULE__,
      :function => :double_quote,
      :grammar => :action
    },
    "batix" => %{
      :description => "back ticks",
      :module => __MODULE__,
      :function => :back_ticks,
      :grammar => :action
    },
    "plusi" => %{
      :description => "plus",
      :module => __MODULE__,
      :function => :plus,
      :grammar => :action
    },
    "plui" => %{
      :description => "plus plus",
      :module => __MODULE__,
      :function => :plus_plus,
      :grammar => :action
    },
    "maini" => %{
      :description => "minus",
      :module => __MODULE__,
      :function => :minus,
      :grammar => :action
    },
    "mui" => %{
      :description => "minus minus",
      :module => __MODULE__,
      :function => :minus_minus,
      :grammar => :action
    },
    "astri" => %{
      :description => "asterisk",
      :module => __MODULE__,
      :function => :asterisk,
      :grammar => :action
    },
    "divi" => %{
      :description => "divide",
      :module => __MODULE__,
      :function => :divide,
      :grammar => :action
    },
    "perci" => %{
      :description => "percentage",
      :module => __MODULE__,
      :function => :percentage,
      :grammar => :action
    },
    "ari" => %{
      :description => "single arrow",
      :module => __MODULE__,
      :function => :single_arrow,
      :grammar => :action
    },
    "dari" => %{
      :description => "double arrow",
      :module => __MODULE__,
      :function => :double_arrow,
      :grammar => :action
    },
    "cari" => %{
      :description => "caret",
      :module => __MODULE__,
      :function => :caret,
      :grammar => :action
    },
    "ami" => %{
      :description => "ampersand",
      :module => __MODULE__,
      :function => :ampersand,
      :grammar => :action
    },
    "dori" => %{
      :description => "dollar",
      :module => __MODULE__,
      :function => :dollar,
      :grammar => :action
    },
    "hasi" => %{
      :description => "hash",
      :module => __MODULE__,
      :function => :hash,
      :grammar => :action
    },
    "aspi" => %{
      :description => "asperand",
      :module => __MODULE__,
      :function => :asperand,
      :grammar => :action
    },
    "escli" => %{
      :description => "exclamation mark",
      :module => __MODULE__,
      :function => :exclamation_mark,
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

  def parenthesis do
    Input.key_list([:"(", :")", :left])
  end

  def braces do
    Input.key_list([:"{", :"}", :left])
  end

  def square_brackets do
    Input.key_list([:"[", :"]", :left])
  end

  def angle_brackets do
    Input.key_list([:<, :>, :left])
  end

  def dot do
    Input.key_list([:.])
  end

  def comma do
    Input.key_list([:","])
  end

  def equal do
    Input.key_list([:=, :space])
  end

  def prespace_equal do
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
    Input.key(:":")
  end

  def semicolon do
    Input.key(:";")
  end

  def question_mark do
    Input.key_list([:space, :"?", :space])
  end

  def quote do
    Input.key_list([:"'", :"'", :left])
  end

  def double_quote do
    Input.key_list([:"\"", :"\"", :left])
  end

  def back_ticks do
    Input.key_list([:"`", :"`", :left])
  end

  def plus do
    Input.key(:+)
  end

  def plus_plus do
    Input.key_list([:+, :+])
  end

  def minus do
    Input.key(:-)
  end

  def minus_minus do
    Input.key_list([:-, :-])
  end

  def asterisk do
    Input.key(:*)
  end

  def divide do
    Input.key(:/)
  end

  def percentage do
    Input.key(:%)
  end

  def single_arrow do
    Input.key_list([:-, :>])
  end

  def double_arrow do
    Input.key_list([:=, :>])
  end

  def caret do
    Input.key(:^)
  end

  def ampersand do
    Input.key(:&)
  end

  def dollar do
    Input.key(:"$")
  end

  def hash do
    Input.key(:"#")
  end

  def asperand do
    Input.key(:@)
  end

  def exclamation_mark do
    Input.key(:!)
  end
end
