defmodule Grafana.Base do
  use HTTPotion.Base
    @docmodule """
    When used, it defines overridable functions that allow you to make custom
    Grafana clients.
    """

    @api_host Application.get_env(:grafana, :api_host)
    @api_key Application.get_env(:grafana, :api_key)

    @doc """
    Prepend URL of API host, so that e.g. Grafana.post can be called with just a
    URL suffix: Grafana.post("/login") => HTTPotion.post("<api_host url>/login")
    """
    def process_url(suffix) do
      @api_host <> suffix
    end
end

defmodule Grafana do
  use Grafana.Base

  @docmodule """
  Tools for getting data from the Grafana API as well as chart objects for
  embedding.
  """
end
