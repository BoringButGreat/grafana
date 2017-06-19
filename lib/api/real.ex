defmodule Grafana.API.Real do
  @moduledoc false

  defp api_host, do: Application.get_env(:grafana, :api_host)
  defp api_key, do: Application.get_env(:grafana, :api_key)
  defp username, do: Application.get_env(:grafana, :username)
  defp password, do: Application.get_env(:grafana, :password)

  defp headers, do: ["Authorization": api_key()]

  # Inside each individual API query, we can use a generic API call by sending the
  # appropriate arguments to the right path.
  #
  # NOTE: if you add a function here and call it elsewhere, you must add a
  # corresponding function to fake.ex. This project will still compile if you
  # don't, but "mix test" will fail - this will likely cause problems for
  # someone else who is using the Grafana API in their project.
  def api_get(path) do
    HTTPotion.get(api_host() <> path, [headers: headers()])
    |> validate
  end
  def api_get(path, query_args) do
    HTTPotion.get(api_host() <> path, [headers: headers(), query: query_args])
    |> validate
  end

  def api_put(path, map) do
    {:ok, body} = Poison.encode(map)
    HTTPotion.put(api_host() <> path, [body: body, headers: headers()])
    |> validate
  end

  def api_post(path) do
    HTTPotion.post(api_host() <> path, [headers: headers()])
    |> validate
  end

  def api_post(path, map) do
    {:ok, body} = Poison.encode(map)
    HTTPotion.post(api_host() <> path, [body: body, headers: headers()])
    |> validate
  end

  def api_patch(path, map) do
    {:ok, body} = Poison.encode(map)
    HTTPotion.patch(api_host() <> path, [body: body, headers: headers()])
    |> validate
  end

  def api_delete(path) do
    HTTPotion.delete(api_host() <> path, [headers: headers()])
  end

  def basic_auth_get(path) do
    HTTPotion.get(api_host() <> path, [basic_auth: {"#{username()}", "#{password()}"}])
    |> validate
  end

  def basic_auth_get(path, query_args) do
    HTTPotion.get(api_host() <> path, [headers: headers(), query: query_args])
    |> validate
  end

  def no_auth_get(path) do
    HTTPotion.get(api_host() <> path)
    |> validate
  end

  def no_auth_put(path, map) do
    {:ok, body} = Poison.encode(map)
    HTTPotion.put(api_host() <> path, [body: body])
    |> validate
  end

  def no_auth_post(path, map) do
    # HTTPotion.post(api_host() <> path, [body: Poison.encode(body)])
    # |> validate
    {:ok, body} = Poison.encode(map)
    HTTPotion.post(api_host() <> path, [body: body])
    |> validate
  end

  defp validate(response) do
    if HTTPotion.Response.success?(response) do
      Poison.decode(response.body)
    else
      {:error, "#{inspect(response)}"}
    end
  end

  def content_type(response) do
    response.headers.hdrs[:"content-type"]
  end

  def image?(response) do
    String.starts_with?(content_type(response), "image")
  end

  def cookie?(response) do
    Keyword.get(response.headers.hdrs, :"set-cookie")
  end
end
