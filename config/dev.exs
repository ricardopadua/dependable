import Config

config :dependable, Dependable.Repo,
  username: System.get_env("POSTGRES_USER", "postgres"),
  password: System.get_env("POSTGRES_PASSWORD", "postgres"),
  hostname: System.get_env("POSTGRES_HOSTNAME", "localhost"),
  database: System.get_env("POSTGRES_DB", "dependable_dev"),
  port: System.get_env("POSTGRES_PORT", "5432"),
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: String.to_integer(System.get_env("POOL_SIZE", "5"))

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"
