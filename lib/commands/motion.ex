defmodule Mu.Commands.Motion do
  require Logger
  alias Mu.Core.System.Input, as: Input

  @behaviour Mu.Core.CommandBehaviour

  @commands %{
    "meft" => %{
      :description => "Move left by <number>",
      :function => :move_left,
      :grammar => :numeric
    },
    "mit" => %{
      :description => "Move right by <number>",
      :function => :move_right,
      :grammar => :numeric
    },
    "mup" => %{
      :description => "Move up by <number>",
      :function => :move_up,
      :grammar => :numeric
    },
    "moun" => %{
      :description => "Move down by <number>",
      :function => :move_down,
      :grammar => :numeric
    },
    "iku" => %{
      :description => "Move to <number>",
      :function => :move_to,
      :grammar => :numeric
    },
    "fi" => %{
      :description => "Move forward a word",
      :function => :forward_word,
      :grammar => :numeric
    },
    "bi" => %{
      :description => "Move back a word",
      :function => :back_word,
      :grammar => :numeric
    },
    "stine" => %{
      :description => "Move to start of line",
      :function => :start_line,
      :grammar => :action
    },
    "eldin" => %{
      :description => "Move to end of line",
      :function => :end_line,
      :grammar => :action
    },
    "kai" => %{
      :description => "Top of document",
      :function => :top,
      :grammar => :action
    },
    "jin" => %{
      :description => "Bottom of document",
      :function => :bottom,
      :grammar => :action
    },
    "abi" => %{
      :description => "Insert above current line",
      :function => :insert_above,
      :grammar => :action
    },
    "beli" => %{
      :description => "Insert below current line",
      :function => :insert_below,
      :grammar => :action
    },
    "seli" => %{
      :description => "Select current character",
      :function => :select,
      :grammar => :action
    },
    "selord" => %{
      :description => "Select current word",
      :function => :select_word,
      :grammar => :action
    },
    "seline" => %{
      :description => "Select current line",
      :function => :select_line,
      :grammar => :action
    },
    "forine" => %{
      :description => "Format current line",
      :function => :format_line,
      :grammar => :action
    },
    "forall" => %{
      :description => "Format document",
      :function => :format_document,
      :grammar => :action
    },
    "desi" => %{
      :description => "Undo",
      :function => :undo,
      :grammar => :numeric
    },
    "remi" => %{
      :description => "Redo",
      :function => :redo,
      :grammar => :numeric
    },
    "dili" => %{
      :description => "Delete",
      :function => :delete,
      :grammar => :numeric
    },
    "diword" => %{
      :description => "Delete word",
      :function => :delete_word,
      :grammar => :numeric
    },
    "diline" => %{
      :description => "Delete line",
      :function => :delete_line,
      :grammar => :numeric
    },
    "cheli" => %{
      :description => "Change",
      :function => :change,
      :grammar => :action
    },
    "cheword" => %{
      :description => "Change word",
      :function => :change_word,
      :grammar => :numeric
    },
    "cheline" => %{
      :description => "Change line",
      :function => :change_line,
      :grammar => :numeric
    },
    "ili" => %{
      :description => "Insert mode",
      :function => :insert_mode,
      :grammar => :action
    },
    "ali" => %{
      :description => "Append",
      :function => :append,
      :grammar => :action
    },
    "gui" => %{
      :description => "Escape",
      :function => :exit,
      :grammar => :action
    },
    "hori" => %{
      :description => "Split horizontal",
      :function => :split_horizontal,
      :grammar => :action
    },
    "verti" => %{
      :description => "Split vertical",
      :function => :split_vertical,
      :grammar => :action
    },
    "veft" => %{
      :description => "Switch split left",
      :function => :switch_left,
      :grammar => :action
    },
    "vit" => %{
      :description => "Switch split right",
      :function => :switch_right,
      :grammar => :action
    },
    "vup" => %{
      :description => "Switch split up",
      :function => :switch_up,
      :grammar => :action
    },
    "voun" => %{
      :description => "Switch split down",
      :function => :switch_down,
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

  def top do
    Input.key_list([:escape, :g, :g])
  end

  def bottom do
    Input.key_list([:escape, :G])
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

  def split_horizontal do
    Input.key_list([:escape, :":", :s, :p, :enter])
  end

  def split_vertical do
    Input.key_list([:escape, :":", :v, :s, :enter])
  end

  def switch_left do
    Input.key(:escape)
    Input.key_control(:w)
    Input.key(:left)
  end

  def switch_right do
    Input.key(:escape)
    Input.key_control(:w)
    Input.key(:right)
  end

  def switch_up do
    Input.key(:escape)
    Input.key_control(:w)
    Input.key(:up)
  end

  def switch_down do
    Input.key(:escape)
    Input.key_control(:w)
    Input.key(:down)
  end
end
