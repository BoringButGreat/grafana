defmodule Grafana.Dashboard do
  use Grafana.API

  @path "/api/dashboards"

  @doc """
  Get the home dashboard
  """
  def home, do: api_get "#{@path}/home"
  def get, do: home

  @doc """
  Get a dashboard with the given slug. Slug is the url-friendly version
  of the dashboard title.
  """
  def get(slug), do: api_get "#{@path}/db/#{slug}"

  @doc """
  Update an existing dashboard as specified in json.
  """
  def update(json), do: api_post "#{@path}/db", json

  @doc """
  Create a new dashboard specified by json.
  """
  def new(json), do: update json

  @doc """
  Delete an existing dashboard with the given slug. Slug is the url-friendly
  version of the dashboard title.
  """
  def delete(slug), do: api_delete "#{@path}/db/#{slug}"

  @doc """
  Get all the available tags for dashboards.
  """
  def tags, do: api_get "#{@path}/tags"

  @doc """
  Get dashboard from json file.
  """
  def get_from_json(json), do api_get "/file/" <> Poison.encode(json)

  @doc """
  Search dashboards with given parameters. "starred" is a boolean flag
  indicating whether only starred dashboards should be returned. "tagcloud"
  is a boolean indicating if a tagcloud should be returned.
  """
  def search(query, starred, tag, tagcloud) do
    api_get "/api/search", %{query: query, starred: starred, tag: tag, tagcloud: tagcloud}
  end
end
