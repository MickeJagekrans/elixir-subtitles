defmodule Utils do
  def normalize_line_endings(text), do: Regex.replace(~r/\r\n?/, text, "\n")

  def split_lines(text) do
    text |> normalize_line_endings() |> String.split("\n\n", trim: true)
  end 

  def add_closing_line_breaks(string), do: string <> "\n\n"

  def format_time(%Time{hour: h, minute: m, second: s, microsecond: {us, _}}, sep) do
    "#{pad(h)}:#{pad(m)}:#{pad(s)}#{sep}#{format_microsecond(us)}"
  end

  defp format_microsecond(us), do: "#{div(us, 1000)}" |> pad(3)

  defp pad(time, count\\2), do: "#{time}" |> String.pad_leading(count, ["0"])
end
