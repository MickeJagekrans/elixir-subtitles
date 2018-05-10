defmodule Subtitles.Vtt.ParserSpec do
  use ESpec

  describe "#parse" do
    subject do: sub() |> Subtitles.Vtt.Parser.parse()

    describe "valid sub" do
      let :sub, do: File.read!("spec/fixtures/test.vtt")
      let :expected, do: {:ok, %Subtitle{
        cues: [
          %Cue{
            from: ~T[00:00:00.000],
            to: ~T[00:00:10.000],
            parts: [
              %CuePart{text_data: "Example entry 1: Hello <b>world</b>."}
            ]
          },
          %Cue{
            from: ~T[00:00:25.000],
            to: ~T[00:00:35.000],
            parts: [
              %CuePart{text_data: "Example entry 2: Another entry."},
              %CuePart{text_data: "This one has multiple lines."}
            ]
          },
          %Cue{
            from: ~T[00:01:03.000],
            to: ~T[00:01:06.500],
            parts: [
              %CuePart{text_data: "Example entry 3: That stuff to the right of the timestamps are cue settings."}
            ]
          },
          %Cue{
            from: ~T[00:03:10.000],
            to: ~T[00:03:20.000],
            parts: [
              %CuePart{text_data: "Example entry 4: Entries can even include timestamps."},
              %CuePart{text_data: "For example:This becomes visible five seconds"},
              %CuePart{text_data: "after the first part."}
            ]
          }
        ]
      }}

      it do: should eq expected()
    end

    describe "crlf subtitle" do
      let :sub, do: "WEBVTT\r\n\r\n00:00:00.000 --> 00:00:02.040\r\nThis is the sub text\r\n\r\n"
      let :expected, do: {:ok, %Subtitle{
        cues: [
          %Cue{
            from: ~T[00:00:00.000],
            to: ~T[00:00:02.040],
            parts: [
              %CuePart{text_data: "This is the sub text"}
            ]
          }
        ]
      }}

      it do: should eq expected()
    end
  end
end
