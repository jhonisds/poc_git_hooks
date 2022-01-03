import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :poc_git_hooks, PocGitHooks.Repo,
  username: "postgres",
  password: "postgres",
  database: "poc_git_hooks_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :poc_git_hooks, PocGitHooksWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "ul7eFX0xc5ghqs6d2/l2Vz++dDqOcQFh+ikdbvgghXIMDjmVACjm8P54h4j9THBJ",
  server: false

# In test we don't send emails.
config :poc_git_hooks, PocGitHooks.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
