defmodule Subtitles.SrtParserSpec do
  use ESpec

  describe "#parse" do
    subject do: sub() |> Subtitles.SrtParser.parse()

    describe "valid sub" do
      let :sub, do: File.read!("spec/fixtures/test.srt")
      let :expected, do: [%{
          from: "00:01:40,760",
          to: "00:01:42,040",
          parts: ["Minioner."]
        }, %{
          from: "00:01:42,520",
          to: "00:01:46,280",
          parts: ["Minioner har funnits på planeten", "mycket längre än vi."]
        }, %{
          from: "00:01:46,800",
          to: "00:01:51,040",
          parts: ["De har många olika namn.", "Dave, Carl, Paul, Mike."]
        }, %{
          from: "00:01:53,120",
          to: "00:01:54,880",
          parts: ["Den där heter Norbert."]
        }, %{
          from: "00:01:55,800",
          to: "00:01:57,200",
          parts: ["Han är en idiot."]
        }]

      it do: should eq expected()
    end 
  end
end
