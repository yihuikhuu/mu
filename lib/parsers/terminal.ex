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

  def move_left(times \\ 1) do
    Logger.info(times)
    System.Input.key(:left, times)
  end

  def move_right(times \\ 1) do
    Logger.info(times)
    System.Input.key(:right, times)
  end

  def move_up(times \\ 1) do
    Logger.info(times)
    System.Input.key(:up, times)
  end

  def move_down(times \\ 1) do
    Logger.info(times)
    System.Input.key(:down, times)
  end
end
