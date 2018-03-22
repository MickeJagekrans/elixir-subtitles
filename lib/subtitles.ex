defmodule Subtitles do
  def get_format(subtitle) do
    subtitle |> String.starts_with?("WEBVTT") && :vtt || :srt
  end
end
