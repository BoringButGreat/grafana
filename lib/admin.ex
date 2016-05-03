defmodule Grafana.Admin do
  use Grafana.API

  @path "/api/admin"

  @doc """
  Get global admin settings.
  """
  def settings, do: api_get "#{@path}/settings"

  @doc """
  Create new global user as specified by json.
  """
  def new_user(json), do: api_post "#{@path}/users", json

  @doc """
  Set password for user with given id. Json format is {"password": "<newpassword>"}.
  """
  def set_password(user_id, json), do: api_put "#{@path}/users/#{user_id}/password", json

  @doc """
  Set permissions for given user as specified by json.
  """
  def set_permissions(user_id, json), do: api_put "#{@path}/users/#{user_id}/permissions", json

  @doc """
  Delete global user with given id.
  """
  def delete_user(id), do: api_delete "#{@path}/users/#{id}"
end
