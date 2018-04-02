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
      :function => :space,
      :grammar => :action
    },
    "blin" => %{
      :description => "line break",
      :function => :line_break,
      :grammar => :action
    },
    "tabi" => %{
      :description => "tab",
      :function => :tab,
      :grammar => :action
    },
    "plex" => %{
      :description => "parenthesis",
      :function => :parenthesis,
      :grammar => :action
    },
    "brex" => %{
      :description => "braces",
      :function => :braces,
      :grammar => :action
    },
    "squex" => %{
      :description => "square brackets",
      :function => :square_brackets,
      :grammar => :action
    },
    "angex" => %{
      :description => "angle brackets",
      :function => :angle_brackets,
      :grammar => :action
    },
    "dotti" => %{
      :description => "dot",
      :function => :dot,
      :grammar => :action
    },
    "kama" => %{
      :description => "comma",
      :function => :comma,
      :grammar => :action
    },
    "quali" => %{
      :description => "equal without pre-space",
      :function => :equal,
      :grammar => :action
    },
    "qualis" => %{
      :description => "equal with pre-space",
      :function => :spaced_equal,
      :grammar => :action
    },
    "dequal" => %{
      :description => "double equal",
      :function => :double_equal,
      :grammar => :action
    },
    "teaqual" => %{
      :description => "triple equal",
      :function => :triple_equal,
      :grammar => :action
    },
    "lani" => %{
      :description => "less than or equal",
      :function => :less_than_equal,
      :grammar => :action
    },
    "gani" => %{
      :description => "greater than or equal",
      :function => :greater_than_equal,
      :grammar => :action
    },
    "lan" => %{
      :description => "less than",
      :function => :less_than,
      :grammar => :action
    },
    "gan" => %{
      :description => "greater than",
      :function => :greater_than,
      :grammar => :action
    },
    "clon" => %{
      :description => "colon",
      :function => :colon,
      :grammar => :action
    },
    "slon" => %{
      :description => "semi colon",
      :function => :semicolon,
      :grammar => :action
    },
    "queso" => %{
      :description => "question mark",
      :function => :question_mark,
      :grammar => :action
    },
    "swote" => %{
      :description => "quote",
      :function => :quote,
      :grammar => :action
    },
    "dwote" => %{
      :description => "double quote",
      :function => :double_quote,
      :grammar => :action
    },
    "batix" => %{
      :description => "back ticks",
      :function => :back_ticks,
      :grammar => :action
    },
    "plusi" => %{
      :description => "plus",
      :function => :plus,
      :grammar => :action
    },
    "plui" => %{
      :description => "plus plus",
      :function => :plus_plus,
      :grammar => :action
    },
    "maini" => %{
      :description => "minus",
      :function => :minus,
      :grammar => :action
    },
    "mui" => %{
      :description => "minus minus",
      :function => :minus_minus,
      :grammar => :action
    },
    "astri" => %{
      :description => "asterisk",
      :function => :asterisk,
      :grammar => :action
    },
    "divi" => %{
      :description => "divide",
      :function => :divide,
      :grammar => :action
    },
    "perci" => %{
      :description => "percentage",
      :function => :percentage,
      :grammar => :action
    },
    "ari" => %{
      :description => "single arrow",
      :function => :single_arrow,
      :grammar => :action
    },
    "dari" => %{
      :description => "double arrow",
      :function => :double_arrow,
      :grammar => :action
    },
    "cari" => %{
      :description => "caret",
      :function => :caret,
      :grammar => :action
    },
    "ami" => %{
      :description => "ampersand",
      :function => :ampersand,
      :grammar => :action
    },
    "dori" => %{
      :description => "dollar",
      :function => :dollar,
      :grammar => :action
    },
    "hasi" => %{
      :description => "hash",
      :function => :hash,
      :grammar => :action
    },
    "aspi" => %{
      :description => "asperand",
      :function => :asperand,
      :grammar => :action
    },
    "escli" => %{
      :description => "exclamation mark",
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
