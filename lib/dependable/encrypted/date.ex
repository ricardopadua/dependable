defmodule Dependable.Encrypted.Date do
  @moduledoc false

  use Cloak.Ecto.Date, vault: Dependable.Vault
end
