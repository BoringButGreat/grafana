defmodule Grafana.Dashboard do
  use Grafana.API
  import Grafana

  @path "/api/dashboards"

  @doc """
  Get the home dashboard

    iex> {:ok, dash} = Grafana.Dashboard.home
    ...> Map.keys(dash)
    ["dashboard", "meta"]

    iex> {:ok, dash} = Grafana.Dashboard.get
    ...> Map.keys(dash)
    ["dashboard", "meta"]
  """
  def home, do: api_get "#{@path}/home"
  def get, do: home

  @doc """
  Get a dashboard with the given slug. Slug is the url-friendly version
  of the dashboard title.

    iex> {:ok, dash} = Grafana.Dashboard.get "worldping-endpoint-dns"
    ...> Map.keys(dash)
    ["dashboard", "meta"]
  """
  def get(slug), do: api_get "#{@path}/db/#{slug}"

  @doc """
  Update an existing dashboard as specified in json.

    iex> {:ok, dash} = Grafana.Dashboard.update(%{})
    ...> Map.keys(dash)
    ["slug", "status", "version"]
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

    iex> {:ok, tags} = Grafana.Dashboard.tags
    ...> Map.keys(hd(tags))
    ["count", "term"]
  """
  def tags, do: api_get "#{@path}/tags"

  @doc """
  Get dashboard from json file.
  """
  def get_from_json(json), do: api_get "/file/" <> Poison.encode(json)

  @doc """
  Search dashboards with given parameters. "starred" is a boolean flag
  indicating whether only starred dashboards should be returned. "tagcloud"
  is a boolean indicating if a tagcloud should be returned.

    iex> {:ok, search} = Grafana.Dashboard.search("", false, "Endpoints", false)
    ...> Map.keys(hd(search))
    ["id", "isStarred", "tags", "title", "type", "uri"]
  """
  def search(query, starred, tag, tagcloud) do
    api_get "/api/search", %{query: query, starred: starred, tag: tag, tagcloud: tagcloud}
  end

  @doc """
  Format dashboard parameters into JSON.

  Model:
  {
    "dashboard": {
      "id": null,
      "title": "Production Overview",
      "tags": [ "templated" ],
      "timezone": "browser",
      "rows": [
        {
        }
      ],
      "schemaVersion": 6,
      "version": 0
    },
    "overwrite": false
  }
  """
  def params_to_json(
    id \\ "null",
    title \\ "new dashboard",
    tags \\ [],
    rows \\ [],
    overwrite \\ false,
    version \\ 0,
    editable \\ false,
    style \\ "light"
  )
  def params_to_json(id, title, tags, rows, overwrite, version, editable, style) do
    %{
      dashboard: %{
        id: id,
        title: title,
        tags: tags,
        timezone: "browser",
        editable: editable,
        style: style,
        rows: rows,
        schemaVersion: 6,
        version: version
      },
      overwrite: overwrite
    }
    |> Poison.encode
    |> verify_json
  end
end
