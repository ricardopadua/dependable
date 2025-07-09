defmodule Dependable.Encrypted.EncodedBinary do
  @moduledoc false

  use Cloak.Ecto.Binary, vault: Dependable.Vault

  def embed_as(:json), do: :dump

  def dump(nil), do: {:ok, nil}

  def dump(value) do
    with {:ok, encrypted} <- super(value) do
      {:ok, Base.encode64(encrypted)}
    end
  end

  def load(nil), do: {:ok, nil}

  def load(value), do: super(Base.decode64!(value))
end
