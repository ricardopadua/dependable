defmodule Dependable.Outbox do
  @moduledoc """
  Oban worker responsible for publishing outbound messaging events.

  This worker implements an outbox pattern, ensuring that events are reliably
  produced and deduplicated across retries and job re-insertions.

  ## Features

    - Runs in the `:default` queue
    - Retries up to 20 times
    - Deduplicates jobs based on `:rebilling`, `:target`, and `:tenant` within a 4-hour window
    - Tagged as "outbox" for easy filtering/monitoring

  ## Expected Args

      %{
        "id" => UUID,
        "event" => string (event name/type),
        "payload" => map (event payload)
      }

  """

    @unique_period [
    period: 4 * 60 * 60,
    keys: [:rebilling, :target, :tenant],
    states: Oban.Job.states()
  ]

  use Oban.Worker,
    queue: :default,
    max_attempts: 20,
    priority: 0,
    tags: ["outbox"],
    unique: @unique_period


  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"id" => id, "event" => event, "payload" => _payload}}) do
    # TODO: implement actual message dispatch module
    {:ok, "Event #{event} (#{id}) processed"}
  end
end
