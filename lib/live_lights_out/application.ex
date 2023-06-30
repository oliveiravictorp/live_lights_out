defmodule LiveLightsOut.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      LiveLightsOutWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: LiveLightsOut.PubSub},
      # Start Finch
      {Finch, name: LiveLightsOut.Finch},
      # Start the Endpoint (http/https)
      LiveLightsOutWeb.Endpoint
      # Start a worker by calling: LiveLightsOut.Worker.start_link(arg)
      # {LiveLightsOut.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveLightsOut.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LiveLightsOutWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
