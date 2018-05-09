defmodule Subtitles.Srt.Parser do
  def parse(subtitle) do
    subs = subtitle
      |> Utils.split_lines()
      |> Enum.map(&parse_cue/1)
      |> Subtitle.new()

    {:ok, subs}
  end

  defp parse_cue(cue), do: cue |> String.split("\n", trim: true) |> make_subtitle()

  defp make_subtitle([_, timing|parts]) do
    [from, to] = timing |> String.split(" --> ")

    Cue.new(from, to, parts)
  end
end
