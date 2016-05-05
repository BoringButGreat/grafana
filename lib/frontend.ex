defmodule Grafana.Frontend do
  use Grafana.API

  @path "/api/frontend/settings"

  @doc """
  Get frontend settings.

    iex> {:ok, front} = Grafana.Frontend.get
    ...> Map.keys(front)
    ["allowOrgCreate", "appSubUrl", "authProxyEnabled", "buildInfo", "datasources",
     "defaultDatasource", "panels"]
  """
  def get, do: api_get @path
end
