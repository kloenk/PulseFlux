defmodule PulseFlux.MixProject do
  use Mix.Project

  def project do
    [
      app: :pulseflux,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {PulseFlux.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:instream, "~> 2.0"},
      {:websockex, "~> 0.4.3"}
    ]
  end
end
