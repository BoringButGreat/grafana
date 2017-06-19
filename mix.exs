defmodule Grafana.Mixfile do
  use Mix.Project

  def project do
    [app: :grafana,
     version: "0.0.1",
     elixir: "> 1.3.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     docs: docs()
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:ex_doc, :logger, :httpotion, :poison]]
  end

  defp docs do
    [
      source_url: "https://github.com/BoringButGreat/grafana",
      extras: ["README.md"]
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:ex_doc, "> 0.14.0"},
      {:httpotion, "> 3.0.0"},
      {:poison, "~> 2.0"}
    ]
  end
end
