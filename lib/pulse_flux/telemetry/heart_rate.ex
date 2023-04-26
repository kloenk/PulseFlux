defmodule PulseFlux.Telemetry.HeartRate do
  use Instream.Series

  series do
    measurement("heart_rate")

    tag(:user)

    field(:rate)
  end
end
