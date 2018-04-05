defmodule Utils do
  def normalize_line_endings(text), do: Regex.replace(~r/\r\n?/, text, "\n")

  def split_lines(text) do
    text |> normalize_line_endings() |> String.split("\n\n", trim: true)
  end 
end
