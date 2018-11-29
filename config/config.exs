# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :lfa,
  namespace: LFA,
  ecto_repos: [LFA.Repo]

# Configures the endpoint
config :lfa, LFAWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ez8837Uw75GFuxNkI5/6bquCJ9NdzANU/eSy0G9xh8Rf3M+FoS558isi1VKpSPwG",
  render_errors: [view: LFAWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LFA.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :lfa, LFA.Scheduler,
  timezone: "America/New_York",
  jobs: [
    {"0 15 * * *", {LFA.Poster, :send, []}}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
