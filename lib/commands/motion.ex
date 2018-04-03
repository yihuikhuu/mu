defmodule Mu.Commands.Motion do
  require Logger
  alias Mu.Core.System.Input, as: Input

  @behaviour Mu.Core.CommandBehaviour

  @commands %{
    "meft" => %{
      :function => :move_left,
      :grammar => :numeric
    },
    "mit" => %{
      :function => :move_right,
      :grammar => :numeric
    },
    "mup" => %{
      :function => :move_up,
      :grammar => :numeric
    },
    "mon" => %{
      :function => :move_down,
      :grammar => :numeric
    },
    "miv" => %{
      :description => "Move to specific line",
      :function => :move_to,
      :grammar => :numeric
    },
    "fi" => %{
      :function => :forward_word,
      :grammar => :numeric
    },
    "bez" => %{
      :function => :back_word,
      :grammar => :numeric
    },
    "stine" => %{
      :function => :start_line,
      :grammar => :action
    },
    "eldin" => %{
      :function => :end_line,
      :grammar => :action
    },
    "kai" => %{
      :function => :top,
      :grammar => :action
    },
    "jin" => %{
      :function => :bottom,
      :grammar => :action
    },
    "sai" => %{
      :function => :insert_above,
      :grammar => :action
    },
    "sah" => %{
      :function => :insert_below,
      :grammar => :action
    },
    "seli" => %{
      :function => :select,
      :grammar => :action
    },
    "selord" => %{
      :function => :select_word,
      :grammar => :action
    },
    "seline" => %{
      :function => :select_line,
      :grammar => :action
    },
    "forine" => %{
      :function => :format_line,
      :grammar => :action
    },
    "forall" => %{
      :function => :format_document,
      :grammar => :action
    },
    "desi" => %{
      :function => :undo,
      :grammar => :numeric
    },
    "remi" => %{
      :function => :redo,
      :grammar => :numeric
    },
    "dili" => %{
      :function => :delete,
      :grammar => :numeric
    },
    "diword" => %{
      :function => :delete_word,
      :grammar => :numeric
    },
    "dilin" => %{
      :function => :delete_line,
      :grammar => :numeric
    },
    "cheli" => %{
      :function => :change,
      :grammar => :action
    },
    "cheword" => %{
      :function => :change_word,
      :grammar => :numeric
    },
    "chelin" => %{
      :function => :change_line,
      :grammar => :numeric
    },
    "ili" => %{
      :function => :insert_mode,
      :grammar => :action
    },
    "ali" => %{
      :function => :append,
      :grammar => :action
    },
    "eki" => %{
      :function => :escape,
      :grammar => :action
    },
    "hori" => %{
      :function => :split_horizontal,
      :grammar => :action
    },
    "verti" => %{
      :function => :split_vertical,
      :grammar => :action
    },
    "veft" => %{
      :function => :switch_split_left,
      :grammar => :action
    },
    "vit" => %{
      :function => :switch_split_right,
      :grammar => :action
    },
    "vup" => %{
      :function => :switch_split_up,
      :grammar => :action
    },
    "von" => %{
      :function => :switch_split_down,
      :grammar => :action
    }
  }

  def commands do
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
    Input.key_list([:g, :g])
  end

  def bottom do
    Input.key_list([:G])
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
    Input.key(:r)
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

  def escape do
    Input.key(:escape)
  end

  def split_horizontal do
    Input.key_list([:escape, :":", :s, :p, :enter])
  end

  def split_vertical do
    Input.key_list([:escape, :":", :v, :s, :enter])
  end

  def switch_split_left do
    Input.key(:escape)
    Input.key_control(:w)
    Input.key(:left)
  end

  def switch_split_right do
    Input.key(:escape)
    Input.key_control(:w)
    Input.key(:right)
  end

  def switch_split_up do
    Input.key(:escape)
    Input.key_control(:w)
    Input.key(:up)
  end

  def switch_split_down do
    Input.key(:escape)
    Input.key_control(:w)
    Input.key(:down)
  end
end
