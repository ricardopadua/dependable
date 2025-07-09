defmodule Dependable.Encrypted.StringList do
  @moduledoc false

  use Cloak.Ecto.StringList, vault: Dependable.Vault
end
