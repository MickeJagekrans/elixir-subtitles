defmodule SubtitlesSpec do
  use ESpec

  alias Subtitles.Srt
  alias Subtitles.Vtt

  let :vtt, do: File.read!("spec/fixtures/test.vtt")
  let :srt, do: File.read!("spec/fixtures/test.srt")

  describe "#guess_format/1" do
    subject do: sub() |> Subtitles.guess_format()

    context "given a webvtt string" do
      let :sub, do: vtt()

      it do: should eq :Vtt
    end

    context "given an srt string" do
      let :sub, do: srt()

      it do: should eq :Srt
    end

    context "given an srt with CRLF" do
      let :sub, do: "1\r\n00:00:00,000 --> 00:00:01,000\nsome text.\n\n"

      it do: should eq :Srt
    end

    context "given an srt with optional leading newline" do
      let :sub, do: "\n1\n00:00:00,000 --> 00:00:01,000\nsome text.\n\n"

      it do: should eq :Srt
    end

    context "given any other string" do
      let :sub, do: "some random string not matching any other format"

      it do: should eq :UnknownFormat
    end
  end

  describe "#parse/1" do
    subject do: sub() |> Subtitles.parse()

    before do
      allow Vtt.Parser |> to(accept :parse, fn _ -> {:ok, :vtt} end)
      allow Srt.Parser |> to(accept :parse, fn _ -> {:ok, :srt} end)
    end

    context "given a webvtt" do
      let :sub, do: vtt()

      it do
        should eq {:ok, :vtt}
        expect Vtt.Parser |> to(accepted :parse)
      end
    end

    context "given an srt" do
      let :sub, do: srt()

      it do
        should eq {:ok, :srt}
        expect Srt.Parser |> to(accepted :parse)
      end
    end

    context "given any other string" do
      let :sub, do: "some other string"

      it do: should eq {:error, "Unknown subtitle format"}
    end
  end

  describe "#parse/2" do
    subject do: "" |> Subtitles.parse(type())

    before do
      allow Vtt.Parser |> to(accept :parse, fn _ -> {:ok, :vtt} end)
      allow Srt.Parser |> to(accept :parse, fn _ -> {:ok, :srt} end)
    end

    context "given Vtt" do
      let :type, do: :Vtt

      it do
        should eq {:ok, :vtt}
        expect Vtt.Parser |> to(accepted :parse)
      end
    end

    context "given Srt" do
      let :type, do: :Srt

      it do
        should eq {:ok, :srt}
        expect Srt.Parser |> to(accepted :parse)
      end
    end
  end
end
