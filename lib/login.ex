defmodule Grafana.Login do
  use Grafana.API

  @path "/api/login/ping"

  @doc """
  Renew session based on remembered cookie.
  """
  def renew, do: basic_auth_get @path
  def check, do: api_get @path
  def login, do: basic_auth_get @path
end
