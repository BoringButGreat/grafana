defmodule Grafana.Admin do
  use Grafana.API
  import Grafana

  @path "/api/admin"

  @doc """
  Get global admin settings.

    iex> {:ok, settings} = Grafana.Admin.settings
    ...> Map.keys(settings)
    ["DEFAULT","analytics","auth.anonymous","auth.basic","auth.github","auth.google","auth.ldap","auth.proxy","dashboards.json","database","emails","event_publisher","log","log.console","log.file","paths","security","server","session","smtp","users"]
  """
  def settings, do: api_get "#{@path}/settings"

  @doc """
  Create new global user as specified by json.

    iex> {:ok, response} = Grafana.Admin.new_user(%{"name" => "User", "email" => "user@graf.com", "login" => "user", "password" => "userpassword"})
    ...> Map.keys(response)
    ["id","message"]
  """
  def new_user(json), do: api_post "#{@path}/users", json

  @doc """
  Set password for user with given id. Json format is {"password": "<newpassword>"}.

    iex> {:ok, response} = Grafana.Admin.set_password(1, %{"password" => "newpassword"})
    ...> Map.keys(response)
    ["message"]
  """
  def set_password(user_id, json), do: api_put "#{@path}/users/#{user_id}/password", json

  @doc """
  Set permissions for given user as specified by json.

    iex> {:ok, response} = Grafana.Admin.set_permissions(1, %{"isGrafanaAdmin" => true})
    ...> Map.keys(response)
    ["message"]
  """
  def set_permissions(user_id, json), do: api_put "#{@path}/users/#{user_id}/permissions", json

  @doc """
  Delete global user with given id.

    iex> {:ok, response} = Grafana.Admin.delete_user(1)
    ...> Map.keys(response)
    ["message"]
  """
  def delete_user(id), do: api_delete "#{@path}/users/#{id}"

  @doc """
  Format user parameters into JSON.

  Model:
  {
    "name":"User",
    "email":"user@graf.com",
    "login":"user",
    "password":"userpassword"
  }
  """
  def user_params_to_json(name \\ "", email \\ "", login \\ "user", password \\ "password")
  def user_params_to_json(name, email, login, password) do
    %{
      name: name,
      email: email,
      login: login,
      password: password
    }
    |> Poison.encode
    |> verify_json
  end

end
