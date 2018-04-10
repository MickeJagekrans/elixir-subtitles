defmodule Subtitle do
  @enforce_keys [:cues]
  defstruct [:cues]

  def new(cues), do: %Subtitle{cues: cues}
end
