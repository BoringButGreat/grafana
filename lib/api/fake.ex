defmodule Grafana.API.Fake do
  # @api_host Application.get_env(:grafana, :api_host)
  # @api_key Application.get_env(:grafana, :api_key)
  # @headers ["Authorization": @api_key]
  @default "Test not implemented"

  defp priv(path) do
    priv =
      :code.priv_dir(:grafana)
      |> to_string
    priv <> "/mock" <> path
  end

  defp load(path) do
    with {:ok, content} <- File.read(priv(path)),
    do: Poison.decode(content)
  end

  def api_get("/api/datasources"), do: load("/datasources.json")
  def api_get("/api/datasources/" <> id) do
    with {:ok, datasources} <- api_get("/api/datasources") do
      {
        :ok,
        Enum.filter(datasources, &(id == to_string(&1["id"])))
      }
    end
  end
  def api_get("/api/org"), do: load("/currentorg.json")
  def api_get("/api/org/users"), do: load("/currentorg/users.json")
  def api_get("/api/dashboards/home"), do: load("/dashboard.json")
  def api_get("/api/dashboards/tags"), do: load("/dashboard/tags.json")
  def api_get("/api/dashboards/db/" <> _), do: load("/dashboard/db.json")
  def api_get("/api/search", _), do: load("/dashboard/search.json")
  def api_get(_), do: @default
  def api_get(_, _), do: @default

  def api_post(_), do: @default
  def api_post(_, _), do: @default
  def api_put(_), do: @default
  def api_put(_, _), do: @default
  def api_delete(_), do: @default
  def api_delete(_, _), do: @default
  def api_patch(_), do: "test not implemented"
  def api_patch(_, _), do: "test not implemented"
end
