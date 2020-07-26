defmodule NifGoBoom.MixProject do
  use Mix.Project

  def project do
    [
      app: :nif_go_boom,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: [
        nif_go_boom: [
          include_executables_for: [:unix],
          applications: [runtime_tools: :permanent],
          # Change this to false to prevent nif going boom
          reboot_system_after_config: true
        ]
      ]
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
      {:enacl, git: "https://github.com/starbelly/enacl", branch: "fixup-enacl-nif-return"}
    ]
  end
end
