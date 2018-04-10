defmodule Subtitles.VttFormatter do
  def format(%Subtitle{cues: cues}), do: "WEBVTT\n\n" <> build_cues(cues)

  defp build_cues(sub) do
    sub
    |> Enum.map(&build(&1))
    |> Enum.join("\n\n")
    |> Utils.add_closing_line_breaks()
  end

  defp build(sub) do
    build_cue_header(sub) <> build_cue_text(sub.parts)
  end

  defp build_cue_header(%{from: from, to: to}) do
    "#{Utils.format_time(from, ".")} --> #{Utils.format_time(to, ".")}\n" 
  end

  defp build_cue_text(parts), do: parts |> Enum.map(& &1.text_data) |> Enum.join("\n")
end
