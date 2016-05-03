defmodule Grafana.Login do
  use Grafana.API

  @path "/api/login/ping"

  @doc """
  Renew session based on remembered cookie.
  """
  def renew, api_get @path
end
