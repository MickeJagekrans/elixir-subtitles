defmodule SubtitlesSpec do
  use ESpec

  let :vtt, do: File.read!("spec/fixtures/test.vtt")
  let :srt, do: File.read!("spec/fixtures/test.srt")

  describe "#get_format/1" do
    subject do: sub() |> Subtitles.get_format()
    
    context "given a webvtt string" do
      let :sub, do: vtt()

      it do: should eq :vtt
    end

    context "given any other string" do
      let :sub, do: srt()

      it do: should eq :srt
    end
  end
end
