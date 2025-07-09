defmodule Dependable.Encrypted.DateTime do
  @moduledoc false

  use Cloak.Ecto.DateTime, vault: Dependable.Vault
end
