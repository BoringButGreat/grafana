defmodule Grafana.Users do
  use Grafana.API

  @path "/api/users"

  @doc """
  Get all users.

  Note: per Grafana API docs this call must be done with Basic Auth and as Admin
  """
  def get, do: basic_auth_get @path

  @doc """
  Get user with given id.
  """
  def get(id), do: api_get "#{@path}/#{id}"

  @doc """
  Update user with given id as specified by json.
  """
  def update(id, json), do: api_put "#{@path}/#{id}", json

  @doc """
  Get all organizations associated with given user id.
  """
  def orgs(id), do: api_get "#{@path}/#{id}/orgs"
end
