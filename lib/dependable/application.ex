defmodule Dependable.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Dependable.Repo,
      Dependable.Vault,
      {Oban, Application.fetch_env!(:dependable, Oban)}
    ]

    opts = [strategy: :one_for_one, name: Dependable.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
