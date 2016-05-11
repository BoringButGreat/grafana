defmodule Grafana.Render do
  use Grafana.API

  @path "/render/dashboard-solo/db/www_rfp365_com_dns_test"
  # @path "/render/dashboard-solo/db/graph-styles?panelId=3"

  def get_test, do: api_get @path, %{panelId: 1}
end
