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

config :opentelemetry, :resource,
  global: [
    build: System.get_env("SHA"),
    version: System.get_env("APP_VERSION"),
    environment: System.get_env("MIX_ENV"),
    otp: System.otp_release(),
    runtime: "elixir-#{System.version()}"
  ],
  service: [
    name: "dependable"
  ]

config :opentelemetry_exporter,
  otlp_protocol: :http_protobuf,
  otlp_compression: :gzip,
  otlp_endpoint: System.get_env("OPENTELEMETRY_API", "http://localhost:4318"),
  tls_verify: true,
  otlp_headers: [
    {"x-fox-team", System.get_env("OPENTELEMETRY_KEY", "opentelemetry_key")},
    {"x-fox-dataset", "dependable"}
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"
