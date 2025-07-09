defmodule Dependable.Encrypted.Binary do
  @moduledoc false

  use Cloak.Ecto.Binary, vault: Dependable.Vault
end
