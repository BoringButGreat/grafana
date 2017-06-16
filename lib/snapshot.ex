defmodule Grafana.Snapshot do
  use Grafana.API

  @path "/api/snapshots"

  @doc """
  Create a new snapshot as specified by json.

    iex> {:ok, result} = Grafana.Snapshot.new(%{"dashboard" => %{}, "expires" => 3600})
    ...> Map.keys(result)
    ["deleteKey","deleteUrl","key","url"]
  """
  def new(json), do: api_post @path, json

  @doc """
  Get snapshot with given key.

    iex> {:ok, result} = Grafana.Snapshot.get("my_key")
    ...> Map.keys(result)
    ["dashboard","meta"]
  """
  def get(key), do: api_get "#{@path}/#{key}"

  @doc """
  Delete snapshot with given DeleteKey. The DeleteKey is returned when the
  snapshot is created.
  """
  def delete(deletekey), do: api_get "#{@path}-delete/#{deletekey}"

  @doc """
  Build snapshot URL from given key.
  """
  def url_from_key(key), do: "#{Application.get_env(:grafana, :api_host)}/dashboard/snapshot/#{key}"
end
