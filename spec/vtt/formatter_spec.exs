defmodule Subtitles.Vtt.FormatterSpec do
  use ESpec

  describe "#format" do
    subject do: sub() |> Subtitles.Vtt.Formatter.format()

    let :expected, do: File.read!("spec/fixtures/format_test.vtt")
    let :sub, do: %Subtitle{
      cues: [
        %Cue{
          from: ~T[00:01:40.760],
          to: ~T[00:01:42.040],
          parts: [
            %CuePart{text_data: "Minioner."}
          ]
        },
        %Cue{
          from: ~T[00:01:42.520],
          to: ~T[00:01:46.280],
          parts: [
            %CuePart{text_data: "Minioner har funnits på planeten"},
            %CuePart{text_data: "mycket längre än vi."}
          ]
        },
        %Cue{
          from: ~T[00:01:46.800],
          to: ~T[00:01:51.040],
          parts: [
            %CuePart{text_data: "De har många olika namn."},
            %CuePart{text_data: "Dave, Carl, Paul, Mike."}
          ]
        },
        %Cue{
          from: ~T[00:01:53.120],
          to: ~T[00:01:54.880],
          parts: [
            %CuePart{text_data: "Den där heter Norbert."}
          ]
        },
        %Cue{
          from: ~T[00:01:55.800],
          to: ~T[00:01:57.200],
          parts: [
            %CuePart{text_data: "Han är en idiot."}
          ]
        }
      ]
    }

    context "when ok" do
      it do: should eq expected()
    end
  end
end
