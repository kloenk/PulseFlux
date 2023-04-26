defmodule PulseFlux.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PulseFlux.Telemetry.InstreamConnection,
      PulseFlux.Pulsoid
      # Starts a worker by calling: PulseFlux.Worker.start_link(arg)
      # {PulseFlux.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PulseFlux.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
