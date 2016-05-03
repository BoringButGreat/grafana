defmodule Grafana.Datasource do
  use Grafana.API

  @path "/api/datasources/"

  @doc """
  Get all datasources.
  """
  def get, do: api_get @path

  @doc """
  Get single datasource by id.
  """
  def get(id), do: api_get @path <> "#{id}"

  @doc """
  Create a new datasource specified by json.
  """
  def new(json), do: api_post @path, json

  @doc """
  Update datasource with given id, as specified by json.
  """
  def update(id, json), do: api_put @path <> "#{id}", json

  @doc """
  Delete datasource with given id.
  """
  def delete(id), do: api_delete @path <> "#{id}"

  @doc """
  Get all available datasource types.
  """
  def types, do: api_get "#{@path}/plugins"

  @doc """
  Proxies all calls to the actual datasource
  """
  def proxy(id, call), do: api_get "#{@path}/proxy/#{id}/#{call}"
end
