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

    context "given an srt string" do
      let :sub, do: srt()

      it do: should eq :srt
    end

    context "given an srt with CRLF" do
      let :sub, do: "1\r\n00:00:00,000 --> 00:00:01,000\nsome text.\n\n"

      it do: should eq :srt
    end

    context "given an srt with optional leading newline" do
      let :sub, do: "\n1\n00:00:00,000 --> 00:00:01,000\nsome text.\n\n"

      it do: should eq :srt
    end

    context "given any other string" do
      let :sub, do: "some random string not matching any other format"

      it do: should eq :unknown
    end
  end

  describe "#parse/1" do
    subject do: sub() |> Subtitles.parse()

    before do
      allow Subtitles.VttParser |> to(accept :parse, fn _ -> :vtt end)
      allow Subtitles.SrtParser |> to(accept :parse, fn _ -> :srt end)
    end

    context "given a webvtt" do
      let :sub, do: vtt()

      it do
        should eq {:ok, :vtt}
        expect Subtitles.VttParser |> to(accepted :parse)
      end
    end

    context "given an srt" do
      let :sub, do: srt()

      it do
        should eq {:ok, :srt}
        expect Subtitles.SrtParser |> to(accepted :parse)
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
      allow Subtitles.VttParser |> to(accept :parse, fn _ -> :vtt end)
      allow Subtitles.SrtParser |> to(accept :parse, fn _ -> :srt end)
    end

    context "given :vtt" do
      let :type, do: :vtt

      it do
        should eq {:ok, :vtt}
        expect Subtitles.VttParser |> to(accepted :parse)
      end
    end

    context "given :srt" do
      let :type, do: :srt

      it do
        should eq {:ok, :srt}
        expect Subtitles.SrtParser |> to(accepted :parse)
      end
    end

    context "given :unknown" do
      let :type, do: :unknown

      it do: should eq {:error, "Unknown subtitle format"}
    end
  end
end
