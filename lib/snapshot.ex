defmodule Grafana.Snapshot do
  use Grafana.API

  @path "/api/snapshots"

  @doc """
  Create a new snapshot as specified by json.
  """
  def new(json), do: api_post @path, json

  @doc """
  Get snapshot with given key.
  """
  def get(key), do: api_get "#{@path}/#{key}"

  @doc """
  Delete snapshot with given DeleteKey. The DeleteKey is returned when the
  snapshot is created.
  """
  def delete(deletekey), do: api_get "#{@path}-delete/#{deletekey}"
end
