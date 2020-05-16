defmodule NifGoBoom.MixProject do
  use Mix.Project

  def project do
    [
      app: :nif_go_boom,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:enacl, "~> 1.0.0"}
    ]
  end
end
