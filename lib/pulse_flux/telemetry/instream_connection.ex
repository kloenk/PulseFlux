defmodule PulseFlux.Telemetry.InstreamConnection do
  @moduledoc """
  InfluxDB connection
  """
  use Instream.Connection, otp_app: :pulseflux
end
