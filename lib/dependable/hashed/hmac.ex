defmodule Dependable.Hashed.HMAC do
  @moduledoc false

  use Cloak.Ecto.HMAC, otp_app: :dependable
end
