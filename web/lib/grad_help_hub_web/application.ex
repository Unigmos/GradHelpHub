defmodule GradHelpHubWeb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      GradHelpHubWebWeb.Telemetry,
      GradHelpHubWeb.Repo,
      {DNSCluster, query: Application.get_env(:grad_help_hub_web, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: GradHelpHubWeb.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: GradHelpHubWeb.Finch},
      # Start a worker by calling: GradHelpHubWeb.Worker.start_link(arg)
      # {GradHelpHubWeb.Worker, arg},
      # Start to serve requests, typically the last entry
      GradHelpHubWebWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GradHelpHubWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GradHelpHubWebWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
