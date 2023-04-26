defmodule PulseFlux.Pulsoid do
  use WebSockex

  alias PulseFlux.Telemetry.HeartRate

  def start_link(_opts) do
    auth = %{
      "access_token" => config(:access_token)
    }

    url =
      %URI{
        scheme: "wss",
        port: 443,
        host: config(:host),
        path: config(:path)
      }
      |> URI.append_query(URI.encode_query(auth))
      |> URI.to_string()

    WebSockex.start_link(url, __MODULE__, %{})
  end

  def handle_frame({:text, json}, state) do
    Jason.decode(json)
    |> case do
      {:ok, json} ->
        %HeartRate{
          fields: %HeartRate.Fields{
            rate: json["data"]["heart_rate"]
          },
          tags: %HeartRate.Tags{
            user: config(:user, "default")
          },
          timestamp:
            DateTime.from_unix!(json["measured_at"], :millisecond)
            |> DateTime.to_unix(:nanosecond)
        }
        |> PulseFlux.Telemetry.InstreamConnection.write()

      _ ->
        nil
    end

    {:ok, state}
  end

  def handle_frame({type, msg}, state) do
    IO.inspect({type, msg})
    {:ok, state}
  end

  defp config do
    Application.get_env(:pulseflux, PulseFlux.Pulsoid)
  end

  defp config(:host) do
    config(:host, "dev.pulsoid.net")
  end

  defp config(:path) do
    config(:path, "/api/v1/data/real_time")
  end

  defp config(key, default \\ nil) do
    Keyword.get(config(), key, default)
  end
end
