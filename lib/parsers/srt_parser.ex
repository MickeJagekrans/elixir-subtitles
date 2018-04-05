defmodule Subtitles.SrtParser do
  import Tools

  def parse(subtitle) do
    subtitle
    |> Tools.normalize_line_endings()
    |> String.split("\n\n", trim: true)
    |> Enum.map(&parse_cue/1)
  end

  defp parse_cue(cue), do: cue |> String.split("\n") |> make_subtitle()

  defp make_subtitle([_, timing|parts]) do
    [from, to] = timing |> String.split(" --> ")

    Subtitle.new(from, to, parts)
  end
end
