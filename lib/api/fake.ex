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

  # A few API delete/1 calls don't follow the general structure; e.g calls that
  # specify an ID at the end. Define special functions for them above the generic ones.
  def api_delete("/api/dashboards/" <> _), do: load("/delete/api/dashboards/db.json")
  def api_delete("/api/admin/users/" <> _), do: load("/delete/api/admin/users/user.json")
  def api_delete(path), do: load("/delete" <> path <> ".json")
  def api_delete(path, _), do: load("/delete" <> path <> ".json")

  def basic_auth_get(path), do: load(path <> ".json")
  def no_auth_get(path), do: load(path <> ".json")

  def api_post(path), do: load("/post" <> path <> ".json")
  def api_post(path, map) do
    with {:ok, _} <- Poison.encode(map),
    do: load("/post" <> path <> ".json")
  end
  def no_auth_post(path, map) do
    with {:ok, _} <- Poison.encode(map),
    do: load("/post" <> path <> ".json")
  end

  def api_put(_), do: @default
  def api_put(path = "/api/admin/users/" <> _, map) do
    load_path = "/put/api/admin/users/"
    file = cond do
      String.match?(path, ~r[password$]) ->
        "password.json"
      String.match?(path, ~r[permissions$]) ->
        "permissions.json"
      true ->
        "default.json"
    end
    with {:ok, _} <- Poison.encode(map),
    do: load(load_path <> file)
  end
  def api_put(_, map) do
    with {:ok, _} <- Poison.encode(map),
    do: @default
  end
  def api_patch(_), do: @default
  def api_patch(_, map) do
    with {:ok, _} <- Poison.encode(map),
    do: @default
  end
  def no_auth_put(_), do: @default
  def no_auth_put(_, map) do
    with {:ok, _} <- Poison.encode(map),
    do: @default
  end
end
