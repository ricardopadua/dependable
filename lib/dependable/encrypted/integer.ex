defmodule Dependable.Encrypted.Integer do
  @moduledoc false

  use Cloak.Ecto.Integer, vault: Dependable.Vault
end
