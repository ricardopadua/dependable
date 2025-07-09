defmodule Dependable.Repo do
  @moduledoc false

  use Ecto.Repo,
    otp_app: :dependable,
    adapter: Ecto.Adapters.Postgres
end
