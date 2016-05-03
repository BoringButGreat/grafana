defmodule Grafana.Frontend do
  use Grafana.API

  @path "/api/frontend/settings"

  @doc """
  Get frontend settings.
  """
  def get, do: api_get @path
end
