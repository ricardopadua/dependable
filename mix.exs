defmodule Dependable.MixProject do
  use Mix.Project

  def project do
    [
      app: :dependable,
      version: "0.1.21",
      elixir: "~> 1.18",
      elixirc_paths: elixirc_paths(Mix.env()),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      release: release(),
      deps: deps(),
      aliases: aliases(),
      maintainers: ["Ricardo Pádua <ricardopadua@gmail.com>"]
    ]
  end

  def application do
    [
      mod: {Dependable.Application, []},
      extra_applications: extra_applications(Mix.env())
    ]
  end

  defp elixirc_paths(_), do: ["lib"]
  defp extra_applications(_), do: [:logger]

  defp release do
    [
      dependable: [
        steps: [:assemble, :tar],
        include_executables_for: [:unix],
        applications: [dependable: :permanent]
      ]
    ]
  end

  defp deps do
    [
      {:ecto_sql, "~> 3.10"},
      {:postgrex, ">= 0.0.0"},
      {:cloak_ecto, "~> 1.3"},
      {:oban, "~> 2.19.2"},
      {:jason, "~> 1.4"}
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
end
