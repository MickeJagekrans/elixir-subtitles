defmodule Subtitles.SrtParserSpec do
  use ESpec

  describe "#parse" do
    subject do: sub() |> Subtitles.SrtParser.parse()

    describe "valid sub" do
      let :sub, do: File.read!("spec/fixtures/test.srt")
      let :expected, do: %Subtitle{
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

      it do: should eq expected()
    end 

    describe "crlf subtitle" do
      let :sub, do: "1\r\n00:00:00,000 --> 00:00:02,040\r\nThis is the sub text\r\n\r\n"
      let :expected, do: %Subtitle{
        cues: [
          %Cue{
            from: ~T[00:00:00.000],
            to: ~T[00:00:02.040],
            parts: [
              %CuePart{text_data: "This is the sub text"}
            ]
          }
        ]
      }

      it do: should eq expected()
    end

    describe "with leading newline" do
      let :sub, do: "\n1\n00:00:00,000 --> 00:00:02,040\nThis is the sub text\n\n"
      let :expected, do: %Subtitle{
        cues: [
          %Cue{
            from: ~T[00:00:00.000],
            to: ~T[00:00:02.040],
            parts: [
              %CuePart{text_data: "This is the sub text"}
            ]
          }
        ]
      }

      it do: should eq expected()
    end
  end
end
