defmodule Dependable.Factories do
  @moduledoc false

  use ExMachina.Ecto, repo: Dependable.Repo

  use Dependable.Factories.Sample
end
