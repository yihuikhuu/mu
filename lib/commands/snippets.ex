defmodule Mu.Commands.Snippets do
  require Logger
  alias Mu.Core.System.Input, as: Input

  @behaviour Mu.Core.CommandBehaviour
  @moduledoc """
  This parser module handles commands specific to triggering or otherwise handling snippets in vim
  """

  @commands %{
    "vax" => %{
      :function => :expand_snippet,
      :grammar => :single
    },
    "vix" => %{
      :description => "Expand a snippet on a visual selection",
      :function => :expand_visual_snippet,
      :grammar => :single
    }
  }

  def commands do
    @commands
  end

  def expand_snippet(name) do
    if name do
      Input.key_list([:escape, :a])
      Input.string(name)
      Input.key(:tab)
    end
  end

  def expand_visual_snippet(name) do
    if name do
      Input.key(:tab)
      Input.string(name)
      Input.key(:tab)
    end
  end
end
