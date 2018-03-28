defmodule Subtitles do
  alias Subtitles.VttParser
  alias Subtitles.SrtParser

  @srt_cue_matcher ~r/\n?1\n(\d{2}:){2}\d{2},\d{3} --> (\d{2}:){2}\d{2},\d{3}(\n.+)+\n\n/

  def get_format(subtitle) do
    subtitle = subtitle |> normalize_line_endings()

    subtitle |> is_vtt?() && :vtt ||
    subtitle |> is_srt?() && :srt ||
    :unknown
  end

  def parse(subtitle), do: subtitle |> parse(get_format(subtitle))
  def parse(subtitle, :vtt), do: {:ok, subtitle |> VttParser.parse()}
  def parse(subtitle, :srt), do: {:ok, subtitle |> SrtParser.parse()}
  def parse(_, :unknown), do: {:error, "Unknown subtitle format"}

  defp normalize_line_endings(subtitle), do: Regex.replace(~r/\r\n?/, subtitle, "\n")

  defp is_vtt?(subtitle), do: subtitle |> String.starts_with?("WEBVTT")
  defp is_srt?(subtitle), do: @srt_cue_matcher |> Regex.match?(subtitle)
end
