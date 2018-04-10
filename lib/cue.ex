defmodule Cue do
  @enforce_keys [:from, :to, :parts]
  defstruct [:from, :to, :parts]

  def new(from, to, parts) do
    %Cue{
      from: Time.from_iso8601!(from),
      to: Time.from_iso8601!(to),
      parts: parts |> Enum.map(& %CuePart{text_data: &1})
    }
  end
end
