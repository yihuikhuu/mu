defmodule Mu.Commands.Motion do
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
      :grammar => :action
    },
    "wei" => %{
      :description => "Move to end of line",
      :module => __MODULE__,
      :function => :end_line,
      :grammar => :action
    },
    "chashang" => %{
      :description => "Insert above current line",
      :module => __MODULE__,
      :function => :insert_above,
      :grammar => :action
    },
    "chadi" => %{
      :description => "Insert below current line",
      :module => __MODULE__,
      :function => :insert_below,
      :grammar => :action
    },
    "xuanyi" => %{
      :description => "Select current character",
      :module => __MODULE__,
      :function => :select,
      :grammar => :action
    },
    "xuancheng" => %{
      :description => "Select current word",
      :module => __MODULE__,
      :function => :select_word,
      :grammar => :action
    },
    "xuanhang" => %{
      :description => "Select current line",
      :module => __MODULE__,
      :function => :select_line,
      :grammar => :action
    },
    "zheng" => %{
      :description => "Format current line",
      :module => __MODULE__,
      :function => :format_line,
      :grammar => :action
    },
    "quanzheng" => %{
      :description => "Format document",
      :module => __MODULE__,
      :function => :format_document,
      :grammar => :action
    },
    "fuyuan" => %{
      :description => "Undo",
      :module => __MODULE__,
      :function => :undo,
      :grammar => :numeric
    },
    "chongzuo" => %{
      :description => "Redo",
      :module => __MODULE__,
      :function => :redo,
      :grammar => :numeric
    },
    "shanyi" => %{
      :description => "Delete",
      :module => __MODULE__,
      :function => :delete,
      :grammar => :numeric
    },
    "shancheng" => %{
      :description => "Delete word",
      :module => __MODULE__,
      :function => :delete_word,
      :grammar => :numeric
    },
    "shanhang" => %{
      :description => "Delete line",
      :module => __MODULE__,
      :function => :delete_line,
      :grammar => :numeric
    },
    "gaiyi" => %{
      :description => "Change",
      :module => __MODULE__,
      :function => :change,
      :grammar => :action
    },
    "gaicheng" => %{
      :description => "Change word",
      :module => __MODULE__,
      :function => :change_word,
      :grammar => :numeric
    },
    "gaihang" => %{
      :description => "Change line",
      :module => __MODULE__,
      :function => :change_line,
      :grammar => :numeric
    },
    "jin" => %{
      :description => "Insert mode",
      :module => __MODULE__,
      :function => :insert_mode,
      :grammar => :action
    },
    "jia" => %{
      :description => "Append",
      :module => __MODULE__,
      :function => :append,
      :grammar => :action
    },
    "gui" => %{
      :description => "Escape",
      :module => __MODULE__,
      :function => :exit,
      :grammar => :action
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
    # Safe to use to_atom here as we know that the potenial characters are from 0-9
    keys =
      Integer.digits(number)
      |> Enum.reduce([:escape], fn x, acc ->
        acc ++ [x |> Integer.to_string() |> String.to_atom()]
      end)

    Input.key_list(keys ++ [:G])
  end

  def forward_word(times \\ 1) do
    Input.key(:escape)
    Input.key(:w, times)
  end

  def back_word(times \\ 1) do
    Input.key(:escape)
    Input.key(:b, times)
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
    Input.key_list([:escape, :v, :i, :w])
  end

  def select_line do
    Input.key_list([:escape, :V])
  end

  def format_line do
    Input.key_list([:escape, :=, :=])
  end

  def format_document do
    Input.key_list([:escape, :g, :g, :V, :G, :=, :"`", :"`"])
  end

  def undo(times \\ 1) do
    keys =
      Integer.digits(times)
      |> Enum.reduce([:escape], fn x, acc ->
        acc ++ [x |> Integer.to_string() |> String.to_atom()]
      end)

    Input.key_list(keys ++ [:u])
  end

  def redo(times \\ 1) do
    keys =
      Integer.digits(times)
      |> Enum.reduce([:escape], fn x, acc ->
        acc ++ [x |> Integer.to_string() |> String.to_atom()]
      end)

    Input.key_list(keys)
    Input.key_control(:r)
  end

  def delete(times \\ 1) do
    keys =
      Integer.digits(times)
      |> Enum.reduce([:escape], fn x, acc ->
        acc ++ [x |> Integer.to_string() |> String.to_atom()]
      end)

    Input.key_list(keys)
    Input.key(:x)
  end

  def delete_word(times \\ 1) do
    keys =
      Integer.digits(times)
      |> Enum.reduce([:escape], fn x, acc ->
        acc ++ [x |> Integer.to_string() |> String.to_atom()]
      end)

    Input.key_list(keys)
    Input.key_list([:d, :i, :w])
  end

  def delete_line(times \\ 1) do
    keys =
      Integer.digits(times)
      |> Enum.reduce([:escape], fn x, acc ->
        acc ++ [x |> Integer.to_string() |> String.to_atom()]
      end)

    Input.key_list(keys)
    Input.key_list([:d, :d])
  end

  def change do
    Input.key_control(:r)
  end

  def change_word(times \\ 1) do
    keys =
      Integer.digits(times)
      |> Enum.reduce([:escape], fn x, acc ->
        acc ++ [x |> Integer.to_string() |> String.to_atom()]
      end)

    Input.key_list(keys)
    Input.key_list([:c, :i, :w])
  end

  def change_line(times \\ 1) do
    keys =
      Integer.digits(times)
      |> Enum.reduce([:escape], fn x, acc ->
        acc ++ [x |> Integer.to_string() |> String.to_atom()]
      end)

    Input.key_list(keys)
    Input.key_list([:c, :c])
  end

  def insert_mode do
    Input.key(:i)
  end

  def append do
    Input.key(:a)
  end

  def exit do
    Input.key(:escape)
  end
end
