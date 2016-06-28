defmodule Grafana.Organizations do
  use Grafana.API

  @path "/api/orgs"

  @doc """
  Get all organizations.
  """
  def get, do: api_get @path

  @doc """
  Get a specific organization with given id.
  """
  def get(id), do: api_get "#{@path}/#{id}"

  @doc """
  Create an organization
  """
  def create(json), do: api_post "#{@path}", json

  @doc """
  Update organization with id, as specified by json.
  """
  def update(id, json), do: api_put "#{@path}/#{id}", json

  @doc """
  Get all users within a given organization.
  """
  def get_users(org_id), do: api_get "#{@path}/#{org_id}/users"

  @doc """
  Add user to given organization, as specified by json.
  """
  def add_user(org_id, json), do: api_post "#{@path}/#{org_id}/users", json

  @doc """
  Update given user inside given organization, as specified by json.
  """
  def update_user(org_id, user_id, json), do: api_patch "#{@path}/#{org_id}/users/#{user_id}", json

  @doc """
  Delete given user inside given organization.
  """
  def delete_user(org_id, user_id), do: api_delete "#{@path}/#{org_id}/users/#{user_id}"

  def org_params_to_json(name) do
    %{
      name: name
    }
    |> Poison.encode
    |> verify_json
  end
end
