defmodule Subtitles.SrtFormatter do
  def format(subtitles) do
    (subtitles ++ [""])
    |> Enum.with_index(1)
    |> Enum.map(&build(&1))
    |> Enum.join("\n\n")
  end

  defp build({"", _}), do: ""
  defp build({sub, idx}) do
    ["#{idx}\n#{format_time(sub.from)} --> #{format_time(sub.to)}"]
    ++ (sub.parts |> Enum.map(& &1.text_data))
    |> Enum.join("\n")
  end

  defp format_time(time), do: time |> Time.to_string() |> String.replace(".", ",")
end
