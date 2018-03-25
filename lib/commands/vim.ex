defmodule Mu.Commands.Vim do
  require Logger
  alias Mu.Core.System.Input, as: Input

  @behaviour Mu.Core.CommandBehaviour

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
    },
    "qudao" => %{
      :description => "Move to <number>",
      :module => __MODULE__,
      :function => :move_to,
      :grammar => :numeric
    },
    "qian" => %{
      :description => "Move forward a word",
      :module => __MODULE__,
      :function => :forward_word,
      :grammar => :numeric
    },
    "hou" => %{
      :description => "Move back a word",
      :module => __MODULE__,
      :function => :back_word,
      :grammar => :numeric
    },
    "tou" => %{
      :description => "Move to start of line",
      :module => __MODULE__,
      :function => :start_line,
      :grammar => :single
    },
    "wei" => %{
      :description => "Move to end of line",
      :module => __MODULE__,
      :function => :end_line,
      :grammar => :single
    },
    "chashang" => %{
      :description => "Insert above current line",
      :module => __MODULE__,
      :function => :insert_above,
      :grammar => :single
    },
    "chaxia" => %{
      :description => "Insert below current line",
      :module => __MODULE__,
      :function => :insert_below,
      :grammar => :single
    },
    "xuan" => %{
      :description => "Select current character",
      :module => __MODULE__,
      :function => :select,
      :grammar => :single
    },
    "xuanzi" => %{
      :description => "Select current word",
      :module => __MODULE__,
      :function => :select_word,
      :grammar => :single
    },
    "xuanhang" => %{
      :description => "Select current line",
      :module => __MODULE__,
      :function => :select_line,
      :grammar => :single
    }
  }

  def commands() do
    @commands
  end

  def move_left(times \\ 1) do
    Input.key(:left, times)
  end

  def move_right(times \\ 1) do
    Input.key(:right, times)
  end

  def move_up(times \\ 1) do
    Input.key(:up, times)
  end

  def move_down(times \\ 1) do
    Input.key(:down, times)
  end

  def move_to(number \\ 1) do
    Input.key(:escape)
    Input.string("#{number}G")
  end

  def forward_word(times \\ 1) do
    Input.key(:escape)
    Input.key(:w, times)
  end

  def back_word(times \\ 1) do
    Input.key(:escape)
    Input.key("b", times)
  end

  def start_line do
    Input.key_list([:escape, :^])
  end

  def end_line do
    Input.key_list([:escape, :"$"])
  end

  def insert_above do
    Input.key_list([:escape, :O])
  end

  def insert_below do
    Input.key_list([:escape, :o])
  end

  def select do
    Input.key_list([:escape, :v])
  end

  def select_word do
    Input.key([:escape, :v, :i, :w])
  end

  def select_line do
    Input.key([:escape, :V])
  end
end
