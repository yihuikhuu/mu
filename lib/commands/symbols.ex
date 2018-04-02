defmodule Mu.Commands.Symbols do
  require Logger
  alias Mu.Core.System.Input, as: Input

  @behaviour Mu.Core.CommandBehaviour
  @moduledoc """
  This parser module handles commands specific to symbols used while coding
  """

  @commands %{
    "kong" => %{
      :function => :space,
      :grammar => :action
    },
    "blin" => %{
      :function => :line_break,
      :grammar => :action
    },
    "tabi" => %{
      :function => :tab,
      :grammar => :action
    },
    "plex" => %{
      :function => :parenthesis,
      :grammar => :action
    },
    "brex" => %{
      :function => :braces,
      :grammar => :action
    },
    "squex" => %{
      :function => :square_brackets,
      :grammar => :action
    },
    "angex" => %{
      :function => :angle_brackets,
      :grammar => :action
    },
    "dotti" => %{
      :function => :dot,
      :grammar => :action
    },
    "kama" => %{
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
      :function => :double_equal,
      :grammar => :action
    },
    "teaqual" => %{
      :function => :triple_equal,
      :grammar => :action
    },
    "lani" => %{
      :function => :less_than_equal,
      :grammar => :action
    },
    "gani" => %{
      :function => :greater_than_equal,
      :grammar => :action
    },
    "lan" => %{
      :function => :less_than,
      :grammar => :action
    },
    "gan" => %{
      :function => :greater_than,
      :grammar => :action
    },
    "clon" => %{
      :function => :colon,
      :grammar => :action
    },
    "slon" => %{
      :function => :semicolon,
      :grammar => :action
    },
    "quesi" => %{
      :function => :question_mark,
      :grammar => :action
    },
    "swote" => %{
      :function => :single_quote,
      :grammar => :action
    },
    "dwote" => %{
      :function => :double_quote,
      :grammar => :action
    },
    "batix" => %{
      :function => :back_ticks,
      :grammar => :action
    },
    "plusi" => %{
      :function => :plus,
      :grammar => :action
    },
    "plui" => %{
      :function => :plus_plus,
      :grammar => :action
    },
    "maini" => %{
      :function => :minus,
      :grammar => :action
    },
    "mui" => %{
      :function => :minus_minus,
      :grammar => :action
    },
    "astri" => %{
      :function => :asterisk,
      :grammar => :action
    },
    "divi" => %{
      :function => :divide,
      :grammar => :action
    },
    "perci" => %{
      :function => :percentage,
      :grammar => :action
    },
    "ari" => %{
      :function => :single_arrow,
      :grammar => :action
    },
    "dari" => %{
      :function => :double_arrow,
      :grammar => :action
    },
    "cari" => %{
      :function => :caret,
      :grammar => :action
    },
    "ampi" => %{
      :function => :ampersand,
      :grammar => :action
    },
    "dori" => %{
      :function => :dollar,
      :grammar => :action
    },
    "hasi" => %{
      :function => :hash,
      :grammar => :action
    },
    "aspi" => %{
      :function => :asperand,
      :grammar => :action
    },
    "escli" => %{
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

  def single_quote do
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
