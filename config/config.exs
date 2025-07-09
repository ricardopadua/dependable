import Config

config :dependable,
  ecto_repos: [Dependable.Repo],
  generators: [timestamp_type: :utc_datetime]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure the jobs processing lib, Oban
crontab = [
  # each 5 minutes every days
  {"*/5 * * * *", Dependable.Outbox, args: %{}}
]

config :dependable, Oban,
  peer: Oban.Peers.Postgres,
  notifier: Oban.Notifiers.PG,
  repo: Dependable.Repo,
  plugins: [
    {Oban.Plugins.Pruner, limit: 100_000},
    {Oban.Plugins.Cron, crontab: crontab}
  ],
  queues: [
    default: 15
  ]

config :dependable, Dependable.Vault,
  ciphers: [
    default:
      {Cloak.Ciphers.AES.GCM,
       tag: "AES.GCM.V1", key: Base.decode64!(System.get_env("CLOAK_KEY", ""))}
  ]

config :dependable, Dependable.Hashed.HMAC,
  algorithm: :sha512,
  secret: System.get_env("CLOAK_HMAC_KEY", "")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
