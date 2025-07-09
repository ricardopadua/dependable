defmodule Dependable.Encrypted.Map do
  @moduledoc false

  use Cloak.Ecto.Map, vault: Dependable.Vault
end
