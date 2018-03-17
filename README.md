# Mu

The Mu project aims to enable users to control their computer primarily with their voice. The original intent is to enable users to write code via voice commands, but can notionally be applied to most computing needs.

# Dependencies

* Dragon NaturallySpeaking.
  * Currently dependent on Dragon's speech processing engine for speech to text conversion, however, the project does not have any hard dependencies on Dragon itself. The project will be usable with any accurate speech processing engine with support for custom words.

# Technology

* Elixir based command interpreter
* Unix Domain Sockets for communication between speech engine and command interpreter
* AppleScript for triggering key strokes on MacOs
* Windows Script Host for triggering key strokes on Windows (To be confirmed)

# Commands

## Core Commands

* `as-is <text>` : `liu <text>`
  * Types <text> as-is.

## Editor / Vim commands

* `up <number>` : `shang <number>`
  * Moves up <number> of lines
* `down <number>` : `xia <number>`
  * Moves down <number> of lines
* `left <number>` : `zuo <number>`
  * Moves left <number> of lines
* `right <number>` : `you <number>`
  * Moves right <number> of lines

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `mu` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:mu, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/mu](https://hexdocs.pm/mu).
