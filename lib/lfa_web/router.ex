defmodule LFAWeb.Router do
  use LFAWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LFAWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", LFAWeb do
    pipe_through :api

    post "/events", EventController, :event
    get "/message", MessageController, :message
    get "/reactions", MessageController, :reactions
  end
end
