defmodule Subtitles.SrtFormatter do
  def format(subtitles) do
    subtitles
    |> Enum.with_index(1)
    |> Enum.map(&build(&1))
    |> Enum.join("\n\n")
    |> add_closing_line_breaks()
  end

  defp build({sub, idx}) do
    build_cue_header(idx, sub.from, sub.to) <> build_cue_text(sub.parts)
  end

  defp build_cue_header(idx, from, to) do
    "#{idx}\n#{format_time(from)} --> #{format_time(to)}\n"
  end

  defp build_cue_text(parts), do: parts |> Enum.map(& &1.text_data) |> Enum.join("\n")

  defp format_time(%Time{hour: h, minute: m, second: s, microsecond: {us, _}}) do
    "#{pad(h)}:#{pad(m)}:#{pad(s)},#{format_microsecond(us)}"
  end

  defp pad(time, count\\2), do: "#{time}" |> String.pad_leading(count, ["0"])

  defp format_microsecond(us), do: "#{div(us, 1000)}" |> pad(3)

  defp add_closing_line_breaks(srt_string), do: srt_string <> "\n\n"
end
