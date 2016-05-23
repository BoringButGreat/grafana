defmodule Grafana do
  use Grafana.API
  use HTTPotion.Base

  @docmodule """
  Tools for getting data from the Grafana API as well as chart objects for
  embedding.
  """

  @doc """
  Prepend URL of API host, so that e.g. Grafana.post can be called with just a
  URL suffix: Grafana.post("/login") => HTTPotion.post("<api_host url>/login")
  """
  def process_url(suffix) do
    @api_host <> suffix
  end

end
