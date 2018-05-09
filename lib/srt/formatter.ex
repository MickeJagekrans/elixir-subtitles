defmodule Subtitles.Srt.Formatter do
  def format(%Subtitle{cues: cues}) do
    cues
    |> Enum.with_index(1)
    |> Enum.map(&build(&1))
    |> Enum.join("\n\n")
    |> Utils.add_closing_line_breaks()
  end

  defp build({sub, idx}) do
    build_cue_header(idx, sub) <> build_cue_text(sub.parts)
  end

  defp build_cue_header(idx, %{from: from, to: to}) do
    "#{idx}\n#{Utils.format_time(from, ",")} --> #{Utils.format_time(to, ",")}\n"
  end

  defp build_cue_text(parts), do: parts |> Enum.map(& &1.text_data) |> Enum.join("\n")
end
