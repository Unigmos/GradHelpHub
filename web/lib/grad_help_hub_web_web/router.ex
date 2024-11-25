defmodule GradHelpHubWebWeb.Router do
  use GradHelpHubWebWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {GradHelpHubWebWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GradHelpHubWebWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  # Other scopes may use custom stacks.
  # scope "/api", GradHelpHubWebWeb do
  #   pipe_through :api
  # end

  # API用ルーティング
  scope "/api", GradHelpHubWebWeb do
    pipe_through :api

    resources "/errors", ErrorController, only: [:index, :create, :show, :update, :delete]

    resources "/usable_libraries", UsableLibraryController

    get "/search", SearchController, :search

    get "/teapot", TeapotController, :index
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:grad_help_hub_web, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: GradHelpHubWebWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
