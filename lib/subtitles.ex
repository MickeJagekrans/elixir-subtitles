defmodule Subtitles do
  defmodule InputValidationFailure do
    defexception message: "Input failed validation"
  end

  defmodule UnknownFormat.Parser do
    def parse(_), do: {:error, "Unknown subtitle format"}
  end

  @srt_cue_matcher ~r/\n?1\n(\d{2}:){2}\d{2},\d{3} --> (\d{2}:){2}\d{2},\d{3}(\n.+)+\n\n/

  def guess_format(subtitle), do: subtitle |> validate_input |> _guess_format

  def parse(subtitle) do
    subtitle = subtitle |> validate_input

    subtitle |> dispatch(guess_format(subtitle))
  end

  def parse(subtitle, format) do
    subtitle
    |> validate_input
    |> dispatch(format)
  end

  defp dispatch(subtitle, format) do
    parser = Subtitles
      |> Module.concat(format)
      |> Module.concat(Parser)
    parser.parse(subtitle)
  end

  def validate_input(subtitle) do
    if not String.valid?(subtitle) do
      raise InputValidationFailure, message: "Input was not valid UTF-8 string"
    end

    subtitle |> Utils.normalize_line_endings()
  end

  defp _guess_format(subtitle) do
    cond do
      subtitle |> is_vtt?() -> :Vtt
      subtitle |> is_srt?() -> :Srt
      true                  -> :UnknownFormat
    end
  end

  defp is_vtt?(subtitle), do: subtitle |> String.starts_with?("WEBVTT")
  defp is_srt?(subtitle), do: @srt_cue_matcher |> Regex.match?(subtitle)
end
