defmodule Mu.Core.System.Input do
  require Logger

  @moduledoc """
  This module handles the execution of keystrokes via Applescript execution
  """
  @key_codes %{
    # 0x00
    :a => 0,
    # 0x0B
    :b => 11,
    # 0x08
    :c => 8,
    # 0x02
    :d => 2,
    # 0x0E
    :e => 14,
    # 0x03
    :f => 3,
    # 0x05
    :g => 5,
    # 0x04
    :h => 6,
    # 0x22
    :i => 34,
    # 0x26
    :j => 38,
    # 0x28
    :k => 40,
    # 0x25
    :l => 37,
    # 0x2E
    :m => 46,
    # 0x2D
    :n => 45,
    # 0x1F
    :o => 31,
    # 0x23
    :p => 35,
    # 0x0C
    :q => 12,
    # 0x0F
    :r => 15,
    # 0x01
    :s => 1,
    # 0x11
    :t => 17,
    # 0x20
    :u => 32,
    # 0x09
    :v => 9,
    # 0x0D
    :w => 13,
    # 0x07
    :x => 7,
    # 0x10
    :y => 16,
    # 0x06
    :z => 6,
    # 0x32
    :grave => 50,
    # 0x41
    :keypaddecimal => 65,
    # 0x43
    :keypadmultiply => 67,
    # 0x45
    :keypadplus => 69,
    # 0x47
    :keypadclear => 71,
    # 0x4B
    :keypaddivide => 75,
    # 0x4C
    :keypadenter => 76,
    # 0x4E
    :keypadminus => 78,
    # 0x51
    :keypadequals => 81,
    # 0x52
    :keypad0 => 82,
    # 0x53
    :keypad1 => 83,
    # 0x54
    :keypad2 => 84,
    # 0x55
    :keypad3 => 85,
    # 0x56
    :keypad4 => 86,
    # 0x57
    :keypad5 => 87,
    # 0x58
    :keypad6 => 88,
    # 0x59
    :keypad7 => 89,
    # 0x5B
    :keypad8 => 91,
    # 0x5C
    :keypad9 => 92,
    # 0x24
    :return => 36,
    # 0x24
    :"\n" => 36,
    # 0x30
    :tab => 48,
    # 0x30
    :"\t" => 48,
    # 0x31
    :space => 49,
    # 0x31
    :" " => 49,
    # 0x33
    :delete => 51,
    # 0x35
    :escape => 53,
    # 0x37
    :command => 55,
    # 0x38
    :shift => 56,
    # 0x39
    :capslock => 57,
    # 0x3A
    :option => 58,
    # 0x3B
    :control => 59,
    # 0x3C
    :rightshift => 60,
    # 0x3D
    :rightoption => 61,
    # 0x3E
    :rightcontrol => 62,
    # 0x3F
    :function => 63,
    # 0x40
    :f17 => 64,
    # 0x48
    :volumeup => 72,
    # 0x49
    :volumedown => 73,
    # 0x4A
    :mute => 74,
    # 0x4F
    :f18 => 79,
    # 0x50
    :f19 => 80,
    # 0x5A
    :f20 => 90,
    # 0x60
    :f5 => 96,
    # 0x61
    :f6 => 97,
    # 0x62
    :f7 => 98,
    # 0x63
    :f3 => 99,
    # 0x64
    :f8 => 100,
    # 0x65
    :f9 => 101,
    # 0x67
    :f11 => 103,
    # 0x69
    :f13 => 105,
    # 0x6A
    :f16 => 106,
    # 0x6B
    :f14 => 107,
    # 0x6D
    :f10 => 109,
    # 0x6F
    :f12 => 111,
    # 0x71
    :f15 => 113,
    # 0x72
    :help => 114,
    # 0x73
    :home => 115,
    # 0x74
    :pageup => 116,
    # 0x75
    :forwarddelete => 117,
    # 0x76
    :f4 => 118,
    # 0x77
    :end => 119,
    # 0x78
    :f2 => 120,
    # 0x79
    :pagedown => 121,
    # 0x7A
    :f1 => 122,
    # 0x7B
    :left => 123,
    # 0x7C
    :right => 124,
    # 0x7D
    :down => 125,
    # 0x7E
    :up => 126,
    # 0x33
    :backspace => 51,
    # 0x24
    :enter => 36,
    # 0x12
    :"1" => 18,
    # 0x13
    :"2" => 19,
    # 0x14
    :"3" => 20,
    # 0x15
    :"4" => 21,
    # 0x17
    :"5" => 23,
    # 0x16
    :"6" => 22,
    # 0x1A
    :"7" => 26,
    # 0x1C
    :"8" => 28,
    # 0x19
    :"9" => 25,
    # 0x1D
    :"0" => 29,
    # 0x18
    := => 24,
    # 0x1B
    :- => 27,
    # 0x1E
    :"]" => 30,
    # 0x21
    :"[" => 33,
    # 0x27
    :"'" => 39,
    # 0x29
    :";" => 41,
    # 0x2A
    :\\ => 42,
    # 0x2B
    :"," => 43,
    # 0x2C
    :/ => 44,
    # 0x2F
    :. => 47,
    # 0x32
    :"`" => 50
  }

  @key_codes_shift %{
    :A => @key_codes[:a],
    :B => @key_codes[:b],
    :C => @key_codes[:c],
    :D => @key_codes[:d],
    :E => @key_codes[:e],
    :F => @key_codes[:f],
    :G => @key_codes[:g],
    :H => @key_codes[:h],
    :I => @key_codes[:i],
    :J => @key_codes[:j],
    :K => @key_codes[:k],
    :L => @key_codes[:l],
    :M => @key_codes[:m],
    :N => @key_codes[:n],
    :O => @key_codes[:o],
    :P => @key_codes[:p],
    :Q => @key_codes[:q],
    :R => @key_codes[:r],
    :S => @key_codes[:s],
    :T => @key_codes[:t],
    :U => @key_codes[:u],
    :V => @key_codes[:v],
    :W => @key_codes[:w],
    :X => @key_codes[:x],
    :Y => @key_codes[:y],
    :Z => @key_codes[:z],
    :< => @key_codes[:","],
    :> => @key_codes[:.],
    :"{" => @key_codes[:"["],
    :"}" => @key_codes[:"]"],
    :")" => @key_codes[:"0"],
    :"(" => @key_codes[:"9"],
    :! => @key_codes[:"1"],
    :| => @key_codes[:\\],
    :":" => @key_codes[:";"],
    :& => @key_codes[:"7"],
    :% => @key_codes[:"5"],
    :"?" => @key_codes[:/],
    :* => @key_codes[:"8"],
    :"~" => @key_codes[:"`"],
    :@ => @key_codes[:"2"],
    :"$" => @key_codes[:"4"],
    :^ => @key_codes[:"6"],
    :+ => @key_codes[:=],
    :"#" => @key_codes[:"3"],
    :_ => @key_codes[:-],
    :"\"" => @key_codes[:"\'"]
  }

  @key_codes_option %{
    :å => @key_codes[:a],
    :"∫" => @key_codes[:b],
    :ç => @key_codes[:c],
    :"∂" => @key_codes[:d],
    :"´" => @key_codes[:e],
    :ƒ => @key_codes[:f],
    :"©" => @key_codes[:g],
    :"˙" => @key_codes[:h],
    :ˆ => @key_codes[:i],
    :"∆" => @key_codes[:j],
    :"˚" => @key_codes[:k],
    :"¬" => @key_codes[:l],
    :µ => @key_codes[:m],
    :n => @key_codes[:n],
    :ø => @key_codes[:o],
    :π => @key_codes[:p],
    :œ => @key_codes[:q],
    :"®" => @key_codes[:r],
    :ß => @key_codes[:s],
    :"†" => @key_codes[:t],
    :"¨" => @key_codes[:u],
    :"√" => @key_codes[:v],
    :"∑" => @key_codes[:w],
    :"≈" => @key_codes[:x],
    :"¥" => @key_codes[:y],
    :Ω => @key_codes[:z],
    :"¡" => @key_codes[:"1"],
    :"™" => @key_codes[:"2"],
    :"£" => @key_codes[:"3"],
    :"¢" => @key_codes[:"4"],
    :"∞" => @key_codes[:"5"],
    :"§" => @key_codes[:"6"],
    :"¶" => @key_codes[:"7"],
    :"•" => @key_codes[:"8"],
    :ª => @key_codes[:"9"],
    :º => @key_codes[:"0"]
  }

  @key_codes_option_shift %{
    :Å => @key_codes[:a],
    :ı => @key_codes[:b],
    :C => @key_codes[:c],
    :Î => @key_codes[:d],
    :"´" => @key_codes[:e],
    :Ï => @key_codes[:f],
    :"˝" => @key_codes[:g],
    :Ó => @key_codes[:h],
    :ˆ => @key_codes[:i],
    :Ô => @key_codes[:j],
    :"" => @key_codes[:k],
    :Ò => @key_codes[:l],
    :Â => @key_codes[:m],
    :"˜" => @key_codes[:n],
    :Ø => @key_codes[:o],
    :"∏" => @key_codes[:p],
    :Œ => @key_codes[:q],
    :"‰" => @key_codes[:r],
    :Í => @key_codes[:s],
    :ˇ => @key_codes[:t],
    :"¨" => @key_codes[:u],
    :"◊" => @key_codes[:v],
    :"„" => @key_codes[:w],
    :"˛" => @key_codes[:x],
    :Á => @key_codes[:y],
    :"¸" => @key_codes[:z],
    :"⁄" => @key_codes[:"1"],
    :"€" => @key_codes[:"2"],
    :"‹" => @key_codes[:"3"],
    :"›" => @key_codes[:"4"],
    :ﬁ => @key_codes[:"5"],
    :ﬂ => @key_codes[:"6"],
    :"‡" => @key_codes[:"7"],
    :"°" => @key_codes[:"8"],
    :"·" => @key_codes[:"9"],
    :"‚" => @key_codes[:"0"]
  }

  def current_application do
    System.cmd("osascript", [
      "-e",
      ~s(tell application "System Events" to get name of first process where it is frontmost")
    ])
    |> elem(0)
    |> String.trim("\n")
  end

  def string(string) do
    System.cmd("osascript", [
      "-e",
      ~s(tell application "System Events" to keystroke "#{string}")
    ])
  end

  def key(key, times \\ 1) do
    System.cmd("osascript", [
      "-e",
      ~s(tell application "System Events"
          repeat #{times} times 
           key code #{@key_codes[key]}
          end repeat
        end tell)
    ])
  end

  def key_command(key, times \\ 1) do
    System.cmd("osascript", [
      "-e",
      ~s(tell application "System Events"
          repeat #{times} times
           key code #{@key_codes[key]} using command down
          end repeat
      end tell)
    ])
  end

  def key_list(keys) do
    commands =
      Enum.reduce(keys, "", fn x, acc ->
        command =
          "key code " <>
            cond do
              Map.has_key?(@key_codes, x) ->
                "#{@key_codes[x]}"

              Map.has_key?(@key_codes_shift, x) ->
                "#{@key_codes_shift[x]} using shift down"

              Map.has_key?(@key_codes_option, x) ->
                "#{@key_codes_option[x]} using option down"

              Map.has_key?(@key_codes_option_shift, x) ->
                "#{@key_codes_option_shift[x]} using {shift down, option down}"
            end

        acc <> command <> "\n"
      end)

    Logger.info(commands)

    System.cmd("osascript", [
      "-e",
      ~s(tell application "System Events"
          #{commands}
        end tell)
    ])
  end
end
