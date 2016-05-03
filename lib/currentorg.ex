defmodule Grafana.CurrentOrg do
  use Grafana.API

  @path "/api/org"

  @doc """
  Get the current organization.
  """
  def get, do: api_get @path

  @doc """
  Update the current organization as specified by json.
  """
  def update(json), do: api_put @path, json

  @doc """
  Get all users within the current organization.
  """
  def get_users, do: api_get "#{@path}/users"

  @doc """
  Add a user to the current organization, as specified by json.
  """
  def add_user(json), do: api_post "#{@path}/users", json

  @doc """
  Update an existing user with given id, as specified by json.
  """
  def update_user(id, json), do: api_patch "#{@path}/users/#{id}", json

  @doc """
  Delete an existing user with given id.
  """
  def delete_user(id), do: api_delete "#{@path}/users/#{id}"
end
