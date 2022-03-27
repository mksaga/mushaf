defmodule Mushaf.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Mushaf.Repo,
      # Start the Telemetry supervisor
      MushafWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Mushaf.PubSub},
      # Start the Endpoint (http/https)
      MushafWeb.Endpoint
      # Start a worker by calling: Mushaf.Worker.start_link(arg)
      # {Mushaf.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Mushaf.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MushafWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
