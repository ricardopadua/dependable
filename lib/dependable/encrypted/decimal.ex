defmodule Dependable.Encrypted.Decimal do
  @moduledoc false

  use Cloak.Ecto.Decimal, vault: Dependable.Vault
end
