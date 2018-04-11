defmodule Subtitles.Mixfile do
  use Mix.Project

  def project do
    [
      app: :subtitles,
      version: "0.1.0",
      elixir: "~> 1.5",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      description: description(),
      package: package(),
      preferred_cli_env: [espec: :test],
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description do
    """
    Library for manipulating and converting subtitles
    """
  end

  defp package do
    [
      maintainers: ["Mikael Jagekrans"],
      links: %{"GitHub" => "https://github.com/MickeJagekrans/elixir-subtitles"},
      licenses: ["MIT"]
    ]
  end

  defp deps do
    [
      {:espec, "~> 1.5.0", only: :test},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end
end
