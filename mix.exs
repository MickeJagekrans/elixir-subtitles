defmodule Subtitles.Mixfile do
  use Mix.Project

  def project do
    [
      app: :subtitles,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      preferred_cli_env: [espec: :test],
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:espec, "~> 1.5.0", only: :test}
    ]
  end
end
