import Config

config :pulseflux, PulseFlux.Telemetry.InstreamConnection,
  version: :v2,
  auth: [method: :token],
  log: false

if File.exists?("./config/config.secret.exs") do
  import_config("./config.secret.exs")
end
