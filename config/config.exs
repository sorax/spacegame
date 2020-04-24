# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :spacegame,
  ecto_repos: [Spacegame.Repo]

# Configures the endpoint
config :spacegame, SpacegameWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0oDiZhKnS5j43SN6k8ivmfiA4T5C3GxpqdgCsWUpDsQEh7yb0H2gGf6mn4PFCIVV",
  render_errors: [view: SpacegameWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Spacegame.PubSub,
  live_view: [signing_salt: "U18Qq7hF"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
