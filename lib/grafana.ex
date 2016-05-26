defmodule Grafana.Base do
  @docmodule """
  When used, it defines overridable functions that allow you to make custom
  Grafana clients.
  """

  defmacro __using__(_) do
    quote do
      use HTTPotion.Base

      @api_host Application.get_env(:grafana, :api_host)
      @api_key Application.get_env(:grafana, :api_key)

      @doc """
      Prepend URL of API host, so that e.g. Grafana.post can be called with just a
      URL suffix: Grafana.post("/login") => HTTPotion.post("<api_host url>/login")
      """
      def process_url(suffix) do
        IO.inspect(suffix)
        @api_host <> suffix
      end

      def process_request_headers(headers) do
        headers
      end

      def process_response_body(body) do
        {:ok, result} = body |> IO.iodata_to_binary |> Poison.decode
        result |> Enum.map(fn ({key, val}) -> { String.to_atom(key), val } end)
        |> :orddict.from_list
      end
    end
  end
end

defmodule Grafana do
  use Grafana.Base

  @docmodule """
  Tools for getting data from the Grafana API as well as chart objects for
  embedding.
  """
end
