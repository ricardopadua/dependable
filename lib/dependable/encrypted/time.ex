defmodule Dependable.Encrypted.Time do
  @moduledoc false

  use Cloak.Ecto.Time, vault: Dependable.Vault
end
