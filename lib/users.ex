defmodule Grafana.Users do
  use Grafana.API

  @path "/api/users"

  @doc """
  Get all available users.
  """
  def get, do: api_get @path

  @doc """
  Get user with given id.
  """
  def get(id), do: api_get "#{@path}/#{id}"

  @doc """
  Update user with given id as specified by json.
  """
  def update(id), do: api_put "#{@path}/#{id}", json

  @doc """
  Get all organizations associated with given user id.
  """
  def orgs(id), do: api_get "#{@path}/#{id}/orgs"

end
