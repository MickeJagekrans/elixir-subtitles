defmodule Subtitles.VttParser do
  @time_pattern ~r/\d{2}:\d{2}:\d{2}\.\d{3}/
  @unsupported_blocks ["WEBVTT", "NOTE", "REGION", "STYLE"]

  def parse(subtitle) do
    subtitle
    |> Utils.split_lines()
    |> filter_unsupported_blocks()
    |> parse_cues()
  end

  defp filter_unsupported_blocks(blocks) do
    blocks |> Enum.reject(&String.starts_with?(&1, @unsupported_blocks))
  end

  defp parse_cues(blocks) do
    blocks |> Enum.map(fn block ->
      block
      |> String.split("\n")
      |> remove_cue_headers()
      |> make_subtitle()
    end)
  end

  defp remove_cue_headers(cue = [first|rest]) do
    @time_pattern |> Regex.match?(first) && cue || rest
  end

  defp make_subtitle([timings|parts]) do
    [[from], [to]|_] = @time_pattern |> Regex.scan(timings)

    Subtitle.new(from, to, parts |> remove_timestamps())
  end

  defp remove_timestamps(parts) do
    parts |> Enum.map(&Regex.replace(~r/<\d{2}:\d{2}:\d{2}.\d{3}>/, &1, ""))
  end
end
