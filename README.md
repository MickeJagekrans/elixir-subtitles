# Subtitles

**This library provides several tools for manipulating and converting subtitles**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `subtitles` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:subtitles, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/subtitles](https://hexdocs.pm/subtitles).

## Usage

This library only supports subtitles in UTF-8 format.  

All functions convert all line endings to LF before operations are done.

### Tests

Run tests:  

`$ mix espec`

## Functions

### Subtitles

**Subtitles.get_format(subtitle)**

Returns the subtitle format as an atom, defaults to `:unknown`

```
subtitle = "WEBVTT\n\n..."
Subtitles.get_format(subtitle) # :vtt

subtitle = "1\r\n..."
Subtitles.get_format(subtitle) # :srt

subtitle = "Anything else"
Subtitles.get_format(subtitle) # :unknown
```

**Subtitles.parse(subtitle)**

Tries to figure out the format of the subtitle and then parse it  
by using the correct parser, returning a tuple:

```
subtitle = "WEBVTT\n\n..."
Subtitles.parse(subtitle) # {:ok, result}

subtitle = "Anything else"
Subtitles.parse(subtitle) # {:error, "Unknown subtitle format"}
```

**Subtitles.parse(subtitle, type)**

Dispatches the subtitle to the parser of type `type` and returns a tuple (see above):

```
Subtitles.parse(sub, :vtt) == Subtitles.VttParser.parse(sub)
Subtitles.parse(sub, :srt) == Subtitles.SrtParser.parse(sub)
```

### Subtitles.SrtParser/Subtitles.VttParser

**Subtitles.SrtParser.parse(subtitle)**
**Subtitles.VttParser.parse(subtitle)**

Returns a parsed list of all cues in the subtitle in the following format:

```
%Subtitle{
  from: ~T[00:00:00.000], # cue from, Elixir Time
  to: ~T[00:00:12.345],   # cue to, Elixir time
  parts: [
    %SubtitlePart{          # Cue data, one per line
      text_data: "Cue text" # actual text of the cue
    }
  ]
}
```

### Subtitles.SrtFormatter

**Subtitles.SrtFormatter.format(subtitles)**

Takes a list of `Subtitle` structs and returns an srt string

### Subtitles.VttFormatter

**Subtitles.SrtFormatter.format(subtitles)**

Takes a list of `Subtitle` structs and returns a vtt string  

## Notes

The current format detectors are quite dumb and will only match as follows:  

**vtt** -> starts with WEBVTT  

**srt** -> starts with a full cue
