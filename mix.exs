defmodule Dependable.MixProject do
  use Mix.Project

  def project do
    [
      app: :dependable,
      version: "0.1.31",
      elixir: "~> 1.18",
      elixirc_paths: elixirc_paths(Mix.env()),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      release: release(),
      deps: deps(),
      docs: docs(),
      aliases: aliases(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: coveralls(),
      maintainers: ["Ricardo Pádua <ricardopadua@gmail.com>"]
    ]
  end

  def application do
    [
      mod: {Dependable.Application, []},
      extra_applications: extra_applications(Mix.env())
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test"]
  defp elixirc_paths(_), do: ["lib"]

  defp extra_applications(:dev), do: [:logger]
  defp extra_applications(:test), do: [:logger, :mox, :ex_unit]
  defp extra_applications(:prod), do: [:logger, :runtime_tools, :os_mon]

  defp release do
    [
      dependable: [
        steps: [:assemble, :tar],
        include_executables_for: [:unix],
        applications: [dependable: :permanent]
      ]
    ]
  end

  defp coveralls do
    [
      coveralls: :test,
      "coveralls.detail": :test,
      "coveralls.post": :test,
      "coveralls.html": :test
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.30", only: :test},
      {:mox, "~> 1.2", only: :test},
      {:ex_machina, "~> 2.8.0", only: :test},
      {:excoveralls, "~> 0.18.5", only: :test},
      {:bypass, "~> 2.1", only: :test},
      {:benchee, "~> 1.1", only: :dev},
      {:ecto_sql, "~> 3.10"},
      {:postgrex, ">= 0.0.0"},
      {:cloak_ecto, "~> 1.3"},
      {:oban, "~> 2.20.1"},
      {:jason, "~> 1.4"},
      {:telemetry_metrics, "~> 1.0"},
      {:telemetry_poller, "~> 1.0"},
      {:opentelemetry, "~> 1.5"},
      {:opentelemetry_api, "~> 1.4"},
      {:opentelemetry_exporter, "~> 1.8"}
    ]
  end

  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end

  defp docs do
    [
      main: "Dependable",
      logo: "priv/static/logo.png",
      extras: ["README.md"],
      output: "doc/",
      groups_for_modules: []
    ]
  end
end
