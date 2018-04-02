defmodule Mu.Commands.Alphabet do
  require Logger
  alias Mu.Core.System.Input, as: Input

  @behaviour Mu.Core.CommandBehaviour
  @moduledoc """
  This parser module handles commands for spelling out charaters
  """

  @commands %{
    "alfa" => %{
      :function => :alfa,
      :grammar => :action
    },
    "bravo" => %{
      :function => :bravo,
      :grammar => :action
    },
    "charlie" => %{
      :function => :charlie,
      :grammar => :action
    },
    "delta" => %{
      :function => :delta,
      :grammar => :action
    },
    "echo" => %{
      :function => :echo,
      :grammar => :action
    },
    "foxtrot" => %{
      :function => :foxtrot,
      :grammar => :action
    },
    "golf" => %{
      :function => :golf,
      :grammar => :action
    },
    "hotel" => %{
      :function => :hotel,
      :grammar => :action
    },
    "india" => %{
      :function => :india,
      :grammar => :action
    },
    "juliett" => %{
      :function => :juliett,
      :grammar => :action
    },
    "kilo" => %{
      :function => :kilo,
      :grammar => :action
    },
    "lima" => %{
      :function => :lima,
      :grammar => :action
    },
    "mike" => %{
      :function => :mike,
      :grammar => :action
    },
    "november" => %{
      :function => :november,
      :grammar => :action
    },
    "oscar" => %{
      :function => :oscar,
      :grammar => :action
    },
    "papa" => %{
      :function => :papa,
      :grammar => :action
    },
    "quebec" => %{
      :function => :quebec,
      :grammar => :action
    },
    "romeo" => %{
      :function => :romeo,
      :grammar => :action
    },
    "sierra" => %{
      :function => :sierra,
      :grammar => :action
    },
    "tango" => %{
      :function => :tango,
      :grammar => :action
    },
    "uniform" => %{
      :function => :uniform,
      :grammar => :action
    },
    "victor" => %{
      :function => :victor,
      :grammar => :action
    },
    "whiskey" => %{
      :function => :whiskey,
      :grammar => :action
    },
    "x-ray" => %{
      :function => :x,
      :grammar => :action
    },
    "yankee" => %{
      :function => :yankee,
      :grammar => :action
    },
    "zulu" => %{
      :function => :zulu,
      :grammar => :action
    }
  }

  def commands do
    @commands
  end

  def alfa do
    Input.key(:a)
  end

  def bravo do
    Input.key(:b)
  end

  def charlie do
    Input.key(:c)
  end

  def delta do
    Input.key(:d)
  end

  def echo do
    Input.key(:e)
  end

  def foxtrot do
    Input.key(:f)
  end

  def golf do
    Input.key(:g)
  end

  def hotel do
    Input.key(:h)
  end

  def india do
    Input.key(:i)
  end

  def juliett do
    Input.key(:j)
  end

  def kilo do
    Input.key(:k)
  end

  def lima do
    Input.key(:l)
  end

  def mike do
    Input.key(:m)
  end

  def november do
    Input.key(:n)
  end

  def oscar do
    Input.key(:o)
  end

  def papa do
    Input.key(:p)
  end

  def quebec do
    Input.key(:q)
  end

  def romeo do
    Input.key(:r)
  end

  def sierra do
    Input.key(:s)
  end

  def tango do
    Input.key(:t)
  end

  def uniform do
    Input.key(:u)
  end

  def victor do
    Input.key(:v)
  end

  def whiskey do
    Input.key(:w)
  end

  def xray do
    Input.key(:x)
  end

  def yankee do
    Input.key(:y)
  end

  def zulu do
    Input.key(:z)
  end
end
