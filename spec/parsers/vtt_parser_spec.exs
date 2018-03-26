defmodule Subtitles.VttParserSpec do
  use ESpec

  describe "#parse" do
    subject do: sub() |> Subtitles.VttParser.parse()

    describe "valid sub" do
      let :sub, do: File.read!("spec/fixtures/test.vtt")
      let :expected, do: [
        %Subtitle{
          from: ~T[00:00:00.000],
          to: ~T[00:00:10.000],
          parts: [
            %SubtitlePart{text_data: "Example entry 1: Hello <b>world</b>."}
          ]
        },
        %Subtitle{
          from: ~T[00:00:25.000],
          to: ~T[00:00:35.000],
          parts: [
            %SubtitlePart{text_data: "Example entry 2: Another entry."},
            %SubtitlePart{text_data: "This one has multiple lines."}
          ]
        },
        %Subtitle{
          from: ~T[00:01:03.000],
          to: ~T[00:01:06.500],
          parts: [
            %SubtitlePart{text_data: "Example entry 3: That stuff to the right of the timestamps are cue settings."}
          ]
        },
        %Subtitle{
          from: ~T[00:03:10.000],
          to: ~T[00:03:20.000],
          parts: [
            %SubtitlePart{text_data: "Example entry 4: Entries can even include timestamps."},
            %SubtitlePart{text_data: "For example:This becomes visible five seconds"},
            %SubtitlePart{text_data: "after the first part."}
          ]
        }
      ]

      it do: should eq expected()
    end
  end
end
