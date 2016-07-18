defmodule Grafana.Login do
  use Grafana.API

  @doc """
  Login and retrieve cookie.
  """
  def login(username, password) do
    no_auth_post "/login", %{username: username, password: password}
  end

  @doc """
  Renew login with basic auth.

    iex> {:ok, response} = Grafana.Login.renew
    ...> Map.keys(response)
    ["message"]
  """
  def renew, do: basic_auth_get "/api/login/ping"

  @doc """
  Check login without authentication.

    iex> {:ok, response} = Grafana.Login.check
    ...> Map.keys(response)
    ["message"]
  """
  def check, do: no_auth_get "/api/login/ping"
end
