defmodule Subtitles do
  def get_format(subtitle) do
    subtitle = subtitle |> normalize_line_endings()

    subtitle |> is_vtt?() && :vtt ||
    subtitle |> is_srt?() && :srt ||
    :unknown
  end

  defp is_vtt?(subtitle), do: subtitle |> String.starts_with?("WEBVTT")
  defp is_srt?(subtitle), do: Regex.match?(~r/^\n?1\n/, subtitle)

  defp normalize_line_endings(subtitle), do: Regex.replace(~r/\r\n?/, subtitle, "\n")
end
