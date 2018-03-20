defmodule Mix.Tasks.Vocabulary do 
  use Mix.Task

  def run(_) do
    File.write(Application.app_dir(:mu) <> "/priv/vocabulary.json", Poison.Encoder.encode(Mu.Parser.Registry.load_parsers(), [pretty: true]))
  end
end
