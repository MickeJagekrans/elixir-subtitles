defmodule Tools do
  def normalize_line_endings(text), do: Regex.replace(~r/\r\n?/, text, "\n")
end
