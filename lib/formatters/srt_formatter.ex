defmodule Subtitles.SrtFormatter do
  def format(subtitles) do
    (subtitles |> Enum.with_index(1) |> Enum.map(&build(&1)) |> Enum.join("\n\n"))
    <> "\n\n"
  end

  defp build({sub, idx}) do
    ["#{idx}\n#{format_time(sub.from)} --> #{format_time(sub.to)}"]
    ++ (sub.parts |> Enum.map(& &1.text_data))
    |> Enum.join("\n")
  end

  defp format_time(%Time{hour: h, minute: m, second: s, microsecond: {us, _}}) do
    "#{pad(h)}:#{pad(m)}:#{pad(s)},#{format_microsecond(us)}"
  end

  defp pad(time), do: "#{time}" |> String.pad_leading(2, ["0"])

  defp format_microsecond(us), do: "#{us}" |> String.pad_leading(6, ["0"]) |> String.slice(0..2)
end
