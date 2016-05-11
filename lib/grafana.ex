defmodule Grafana do
  use Grafana.API
  use HTTPotion.Base

  @api_host Application.get_env(:grafana, :api_host)
  @api_key Application.get_env(:grafana, :api_key)
  @username Application.get_env(:grafana, :username)
  @password Application.get_env(:grafana, :password)

  @headers ["Authorization": @api_key]

  @docmodule """
  Tools for getting data from the Grafana API as well as chart objects for
  embedding.
  """

  def process_url(suffix) do
    IO.inspect(suffix)
    @api_host <> suffix
  end

  def set_cookie(cookie) do

  end

  def get_cookie do
  end

  # def process_options(options) do
  #   # IO.inspect(options++[basic_auth: {"#{@username}", "#{@password}"}])
  #   # options++[basic_auth: {"#{@username}", "#{@password}"}]
  #   IO.inspect(options)
  #   IO.inspect(get_cookie)
  #   options++["Cookie": get_cookie]
  # end

  def handle_response(response) do
    response
  end

  # def process_response_body(body) do
  #   IO.inspect(body)
  #   {:ok, result} = body |> IO.iodata_to_binary |> Poison.decode
  #   IO.inspect(result)
  #   result |> Enum.map(fn ({key, val}) -> { String.to_atom(key), val } end)
  #   |> :orddict.from_list
  # end

end
