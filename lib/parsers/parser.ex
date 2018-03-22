defmodule Mu.Parser do
  require Logger

  @moduledoc """
  This is the base Parser module. 
  It acts as the initial point of contact for all incoming commands and passes control to the appropriate module.
  """

  def parse(text) do
    String.trim(text, "\n")
    |> String.downcase()
    |> process(%{}, [])
    |> execute()
  end

  def execute(commands) do
    Enum.each(commands, fn command ->
      case command[:arguments] do
        nil -> apply(command.module, command.function, [])
        arguments -> apply(command.module, command.function, [command.arguments])
      end
    end)
  end

  def process(text, context, commands) do
    Logger.info(text)

    if text do
      case String.split(text, " ", parts: 2) do
        [curr, tail] -> handle_word(curr, tail, context, commands)
        [curr] -> handle_word(curr, nil, context, commands)
      end
    else
      case context[:grammar] do
        nil -> commands
        :numeric -> commands ++ [%{context | :arguments => Mu.Parser.Util.Number.parse(context[:arguments])}]
        grammar -> commands ++ [context]
      end
    end
  end

  def handle_word(curr, tail, context, commands) do
    case context[:grammar] do
      # Special case for single parameters
      # We want to take the next word regardless of whether or not it is a command
      :single ->
        process(tail, %{}, commands ++ [Map.put(context, :arguments, curr)])

      # Special case for numeric parameters
      # We want to take the next number; Or skip the argument if next word is not a number
      """
      :numeric ->
        case Float.parse(curr) do
          :error ->
            commands =
              cond do
                context -> commands ++ [context]
                true -> commands
              end

            handle_word(curr, tail, %{}, commands)

          _ ->
            process(
              tail,
              %{},
              commands ++ [Map.put(context, :arguments, String.to_integer(curr))]
            )
        end
        """

      _ ->
        command = get_command(curr)

        if command do
          IO.inspect(context)
          commands =
            case context[:grammar] do
              nil -> commands
              :numeric -> commands ++ [%{context | :argument => Mu.Parser.Util.Number.parse(context[:arguments])}]
              grammar -> commands ++ [context]
            end

          case command[:grammar] do
            :unconstrained ->
              process(
                "",
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

            grammar ->
              process(
                tail,
                %{
                  :grammar => grammar,
                  :module => command.module,
                  :function => command.function
                },
                commands
              )
          end
        else
          case context[:grammar] do
            nil ->
              process(tail, %{}, commands ++ [%{:arguments => curr}])

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

  def get_command(curr) do
    case Mu.Parser.Registry.lookup(curr) do
      nil -> nil
      parser -> parser
    end
  end
end
