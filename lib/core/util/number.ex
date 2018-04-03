defmodule Mu.Core.Util.Number do
  require Logger

  @moduledoc """
  This module handles the conversion from english text to numbers
  """

  @word_values %{
    "zero" => 0,
    "oh" => 0,
    "one" => 1,
    "two" => 2,
    "three" => 3,
    "four" => 4,
    "five" => 5,
    "six" => 6,
    "seven" => 7,
    "eight" => 8,
    "nine" => 9,
    "ten" => 10,
    "eleven" => 11,
    "twelve" => 12,
    "thirteen" => 13,
    "fourteen" => 14,
    "fifteen" => 15,
    "sixteen" => 16,
    "seventeen" => 17,
    "eighteen" => 18,
    "nineteen" => 19,
    "twenty" => 20,
    "thirty" => 30,
    "forty" => 40,
    "fifty" => 50,
    "sixty" => 60,
    "seventy" => 70,
    "eighty" => 80,
    "ninety" => 90,
    "hundred" => trunc(:math.pow(10, 2)),
    "thousand" => trunc(:math.pow(10, 3)),
    "million" => trunc(:math.pow(10, 6)),
    "billion" => trunc(:math.pow(10, 9)),
    "trillion" => trunc(:math.pow(10, 12))
  }

  @multiplier [
    "thousand",
    "million",
    "billion",
    "trillion"
  ]

  def parse(text) do
    if text do
      String.replace(text, "-", " ")
      |> process(nil, 0)
    else
      nil
    end
  end

  def process(text, prior, total) do
    if text do
      case String.split(text, " ", parts: 2) do
        [curr, tail] -> handle_word(curr, tail, prior, total)
        [curr] -> handle_word(curr, nil, prior, total)
      end
    else
      if prior do
        total + prior
      else
        total
      end
    end
  end

  def handle_word(curr, tail, prior, total) do
    curr_value =
      case @word_values[curr] do
        nil -> nil
        value -> value
      end

    if curr_value do
      prior =
        cond do
          prior == nil ->
            curr_value

          total < 100 && prior < 100 && curr_value < 100 ->
            cond do
              curr_value > 0 && curr_value < 10 -> prior + curr_value
              true -> prior * 100 + curr_value
            end

          prior > curr_value ->
            prior + curr_value

          true ->
            prior * curr_value
        end

      if Enum.member?(@multiplier, curr) do
        process(tail, nil, total + prior)
      else
        process(tail, prior, total)
      end
    else
      process(tail, prior, total)
    end
  end
end
