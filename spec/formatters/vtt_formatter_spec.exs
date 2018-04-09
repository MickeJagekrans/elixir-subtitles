defmodule Subtitles.VttFormatterSpec do
  use ESpec

  describe "#format" do
    subject do: sub() |> Subtitles.VttFormatter.format()

    let :expected, do: File.read!("spec/fixtures/format_test.vtt")
    let :sub, do: [
      %Subtitle{
        from: ~T[00:01:40.760],
        to: ~T[00:01:42.040],
        parts: [
          %SubtitlePart{text_data: "Minioner."}
        ]
      },
      %Subtitle{
        from: ~T[00:01:42.520],
        to: ~T[00:01:46.280],
        parts: [
          %SubtitlePart{text_data: "Minioner har funnits på planeten"},
          %SubtitlePart{text_data: "mycket längre än vi."}
        ]
      },
      %Subtitle{
        from: ~T[00:01:46.800],
        to: ~T[00:01:51.040],
        parts: [
          %SubtitlePart{text_data: "De har många olika namn."},
          %SubtitlePart{text_data: "Dave, Carl, Paul, Mike."}
        ]
      },
      %Subtitle{
        from: ~T[00:01:53.120],
        to: ~T[00:01:54.880],
        parts: [
          %SubtitlePart{text_data: "Den där heter Norbert."}
        ]
      },
      %Subtitle{
        from: ~T[00:01:55.800],
        to: ~T[00:01:57.200],
        parts: [
          %SubtitlePart{text_data: "Han är en idiot."}
        ]
      }
    ]

    context "when ok" do
      it do: should eq expected()
    end
  end
end
