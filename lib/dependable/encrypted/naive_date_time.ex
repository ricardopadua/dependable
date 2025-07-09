defmodule Dependable.Encrypted.NaiveDateTime do
  @moduledoc false

  use Cloak.Ecto.NaiveDateTime, vault: Dependable.Vault
end
