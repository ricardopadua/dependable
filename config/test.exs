import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :dependable, Dependable.Repo,
  username: System.get_env("POSTGRES_USER_TEST", "postgres"),
  password: System.get_env("POSTGRES_PASSWORD_TEST", "postgres"),
  hostname: System.get_env("POSTGRES_HOSTNAME_TEST", "localhost"),
  database: System.get_env("POSTGRES_DB_TEST", "dependable_test"),
  port: System.get_env("POSTGRES_PORT_TEST", "5432"),
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: String.to_integer(System.get_env("POOL_SIZE", "2"))

# Print only warnings and errors during test
config :logger, level: :warning
