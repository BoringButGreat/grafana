defmodule Grafana.Login do
  use Grafana.API

  @doc """
  Login and retrieve cookie.
  """
  def login(username, password) do
    no_auth_post "/login", %{username: username, password: password}
  end

  @doc """
  Renew session based on remembered cookie.
  """
  def renew, do: basic_auth_get "/api/login/ping"
  def check, do: no_auth_get "/api/login/ping"
end
