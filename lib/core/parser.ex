defmodule Mu.Core.Parser do
  require Logger
  alias Mu.Core.Util.Number, as: Number

  @moduledoc """
  This is the base Parser module. 
  It acts as the initial point of contact for all incoming commands and passes control to the appropriate module.
  """

  def parse(text) do
    Logger.info(text)

    String.trim(text, "\n")
    |> String.downcase()
    |> process(%{}, [])
    |> execute()
  end

  def execute(commands) do
    Enum.each(commands, fn command ->
      IO.inspect(command)

      case command[:arguments] do
        nil -> apply(command.module, command.function, [])
        arguments -> apply(command.module, command.function, [arguments])
      end
    end)
  end

  def process(text, context, commands) do
    if text do
      case String.split(text, " ", parts: 2) do
        [curr, tail] -> handle_word(curr, tail, context, commands)
        [curr] -> handle_word(curr, nil, context, commands)
      end
    else
      process_context(context, commands)
    end
  end

  def handle_word(curr, tail, context, commands) do
    if context[:grammar] == :single do
      process(tail, %{}, commands ++ [Map.put(context, :arguments, curr)])
    else
      command = get_command(curr)
      IO.inspect(command)

      if command do
        commands = process_context(context, commands)

        case command[:grammar] do
          :unconstrained ->
            process(
              nil,
              %{},
              commands ++
                [
                  %{
                    :grammar => :unconstrained,
                    :module => command.module,
                    :function => command.function,
                    :arguments => tail
                  }
                ]
            )

          :action ->
            process(
              tail,
              %{},
              commands ++
                [
                  %{
                    :grammar => :single,
                    :module => command.module,
                    :function => command.function,
                    :arguments => nil
                  }
                ]
            )

          grammar ->
            process(
              tail,
              %{
                :grammar => grammar,
                :module => command.module,
                :function => command.function,
                :arguments => nil
              },
              commands
            )
        end
      else
        case context[:grammar] do
          nil ->
            # Ignore word if not in any command context
            process(tail, %{}, commands)

          _ ->
            case context[:arguments] do
              nil ->
                process(tail, Map.put(context, :arguments, curr), commands)

              arguments ->
                process(
                  tail,
                  %{context | :arguments => arguments <> " " <> curr},
                  commands
                )
            end
        end
      end
    end
  end

  defp process_context(context, commands) do
    case context[:grammar] do
      nil ->
        commands

      :numeric ->
        commands ++ [%{context | :arguments => Number.parse(context[:arguments])}]

      _ ->
        commands ++ [context]
    end
  end

  defp get_command(curr) do
    case Mu.Core.ParserRegistry.lookup(curr) do
      nil -> nil
      parser -> parser
    end
  end
end
