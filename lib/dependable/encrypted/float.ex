defmodule Dependable.Encrypted.Float do
  @moduledoc false

  use Cloak.Ecto.Float, vault: Dependable.Vault
end
