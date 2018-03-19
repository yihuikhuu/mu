defmodule Mu.Parser.Terminal do
  require Logger
  @behaviour Mu.Parser.Behaviour
  @moduledoc """
  This parser module contains functionality specific to the terminal application
  """

  @commands %{
    "wangzuo" => %{
      :description => "Move left by <number>",
      :module => __MODULE__,
      :function => :move_left,
      :grammar => :numeric
    },
    "wangyou" => %{
      :description => "Move right by <number>",
      :module => __MODULE__,
      :function => :move_right,
      :grammar => :numeric
    },
    "wangshang" => %{
      :description => "Move up by <number>",
      :module => __MODULE__,
      :function => :move_up,
      :grammar => :numeric
    },
    "wangxia" => %{
      :description => "Move down by <number>",
      :module => __MODULE__,
      :function => :move_down,
      :grammar => :numeric
    }
  }

  def commands() do
    @commands
  end

  def move_left(number) do
    System.Input.key(:left)
  end

  def move_right(number) do
    System.Input.key(:right)
  end

  def move_up(number) do
    System.Input.key(:up)
  end

  def move_down(number) do
    System.Input.key(:down)
  end
end
