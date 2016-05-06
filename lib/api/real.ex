defmodule Grafana.API.Real do
  @api_host Application.get_env(:grafana, :api_host)
  @api_key Application.get_env(:grafana, :api_key)
  @username Application.get_env(:grafana, :username)
  @password Application.get_env(:grafana, :password)

  @headers ["Authorization": @api_key]

  # Inside each individual API query, we can use a generic API call by sending the
  # appropriate arguments to the right path.
  def api_get(path) do
    HTTPotion.get(@api_host <> path, [headers: @headers])
    |> validate
  end
  def api_get(path, query_args) do
    HTTPotion.get(@api_host <> path, [headers: @headers, query: query_args])
    |> validate
  end

  def api_put(path, body) do
    HTTPotion.put(@api_host <> path, [body: Poison.encode(body), headers: @headers])
    |> validate
  end

  def api_post(path) do
    HTTPotion.post(@api_host <> path, [headers: @headers])
    |> validate
  end

  def api_post(path, body) do
    HTTPotion.post(@api_host <> path, [body: Poison.encode(body), headers: @headers])
    |> validate
  end

  def api_patch(path, body) do
    HTTPotion.patch(@api_host <> path, [body: Poison.encode(body), headers: @headers])
    |> validate
  end

  def api_delete(path) do
    HTTPotion.delete(@api_host <> path, [headers: @headers])
  end

  def basic_auth_get(path) do
    # HTTPotion.get("http://#{@username}:#{@password}@192.241.244.122:3000" <> path)
    HTTPotion.get(@api_host <> path, [basic_auth: {"#{@username}", "#{@password}"}])
    |> validate
  end

  def no_auth_get(path) do
    HTTPotion.get(@api_host <> path)
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
