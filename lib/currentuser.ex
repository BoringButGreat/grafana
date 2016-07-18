defmodule Grafana.Currentuser do
  use Grafana.API

  @path "/api/user"

  @doc """
  Get the actual current user.

    iex> {:ok, user} = Grafana.Currentuser.get
    ...> Map.keys(user)
    ["email", "isGrafanaAdmin", "login", "name", "orgId", "theme"]
  """
  def get, do: basic_auth_get @path

  @doc """
  Change password for the current user.
  """
  def change_password(json), do: api_put "#{@path}/password", json

  @doc """
  Change organization context for the current user.
  """
  def switch_context(org_id), do: api_post "#{@path}/using/#{org_id}"

  @doc """
  Get orgs for the actual current user.

    iex> {:ok, orgs} = Grafana.Currentuser.orgs
    ...> Map.keys(hd(orgs))
    ["name", "orgId", "role"]
  """
  def orgs, do: basic_auth_get "#{@path}/orgs"

  @doc """
  Star dashboard with given id for the current user.
  """
  def star_dashboard(dashboard_id), do: api_post "#{@path}/stars/dashboard/#{dashboard_id}"

  @doc """
  Unstar dashboard with given id for the current user.
  """
  def unstar_dashboard(dashboard_id), do: api_delete "#{@path}/stars/dashboard/#{dashboard_id}"

end
