defmodule Grafana.API.Fake do
  @moduledoc false

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

  # A few API get/1 calls don't follow the general structure; e.g calls that
  # specify an ID at the end. Define special functions for them here.
  def api_get("/api/dashboards/db/" <> _), do: load("/api/dashboards/db.json")
  def api_get("/api/datasources/" <> id) do
    with {:ok, datasources} <- api_get("/api/datasources") do
      {
        :ok,
        Enum.filter(datasources, &(id == to_string(&1["id"])))
      }
    end
  end

  # All other get/1 calls follow a predictable enough pattern that we can
  # just put test files in a directory structure that mimics the url structure
  # of the API calls.
  def api_get(path), do: load(path <> ".json")

  # Follow the same convention for get/2 calls... define special ones here
  # <TBD>

  # All other get/2 calls follow a predictable patter that is reflected in the
  # directory structure of the test .json files.
  def api_get(path, _), do: load(path <> ".json")

  def api_delete(path), do: {:ok, "TEST: delete #{path}"}
  def api_delete(path, args), do: {:ok, "TEST: delete #{path} with args #{inspect args}"}

  def basic_auth_get(path), do: load(path <> ".json")
  def no_auth_get(path), do: load(path <> ".json")

  def api_post(path), do: load("/post" <> path <> ".json")
  def api_post(path, _), do: load("/post" <> path <> ".json")
  def no_auth_post(path, _), do: load("/post" <> path <> ".json")

  # Other API function tests are not implemented.
  def api_put(_), do: @default
  def api_put(_, _), do: @default
  def api_patch(_), do: @default
  def api_patch(_, _), do: @default
  def no_auth_put(_), do: @default
  def no_auth_put(_, _), do: @default
end
