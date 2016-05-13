defmodule Grafana do
  use Grafana.API
  use HTTPotion.Base

  @api_host Application.get_env(:grafana, :api_host)
  @api_key Application.get_env(:grafana, :api_key)
  @username Application.get_env(:grafana, :username)
  @password Application.get_env(:grafana, :password)

  @auth_header ["Authorization": @api_key]
  @json_header ["Content-Type": "application/json"]

  @docmodule """
  Tools for getting data from the Grafana API as well as chart objects for
  embedding.
  """

  def process_url(suffix) do
    @api_host <> suffix
  end

  def process_request_headers(headers) do
    IO.inspect(headers++@json_header++["Cookie": get_cookie])
    headers++@json_header++["Cookie": get_cookie]
  end

  def set_cookie(cookie) do
    cookie_jar = stringify_cookie_list(cookie)
    max_age = get_max_age(cookie)
    %{cookie: cookie_jar, }
  end

  def get_cookie, do: ""

  def get_max_age(_), do: 604800

  def stringify_cookie_list([]), do: ""
  def stringify_cookie_list([head | []]), do: "#{head}"
  def stringify_cookie_list([head | tail]), do: "#{head}; #{stringify_cookie_list(tail)}"
  def stringify_cookie_list(_), do: ""

  def process_response_body(body) do
    {:ok, result} = body |> IO.iodata_to_binary |> Poison.decode
    result |> Enum.map(fn ({key, val}) -> { String.to_atom(key), val } end)
    |> :orddict.from_list
  end

end
