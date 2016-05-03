defmodule Grafana.API.Real do
  @server Application.get_env(:grafana, :server)
  @username Application.get_env(:grafana, :username)
  @password Application.get_env(:grafana, :password)
  @auth {@username, @password}

  # Inside each individual API query, we can use a generic API call by sending the
  # appropriate arguments to the right path.
  def api_get(path) do
    HTTPotion.get(@server <> path, [basic_auth: @auth])
    |> validate
  end
  def api_get(path, query_args) do
    HTTPotion.get(@server <> path, [basic_auth: @auth, query: query_args])
    |> validate
  end

  def api_put(path, body) do
    HTTPotion.put(@server <> path, [body: body, basic_auth: @auth])
    |> validate
  end
  def api_post(path, body) do
    HTTPotion.post(@server <> path, [body: body, basic_auth: @auth])
    |> validate
  end

  def validate(response) do
    if HTTPotion.Response.success?(response) do
      Poison.decode(response.body)
    else
      {:error, "#{inspect(response)}"}
    end
  end
end
