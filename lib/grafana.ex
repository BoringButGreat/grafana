defmodule Grafana.Base do
  defmacro __using__(_) do
    quote do
      use HTTPotion.Base
    end
  end
end

defmodule Grafana do
  use Grafana.Base

  @docmodule """
  Tools for getting data from the Grafana API as well as chart objects for
  embedding.
  """
  # validate Poison response and strip out json value
  def verify_json({:ok, json}), do: json
  def verify_json({_, response}), do: "#{inspect(response)}"
end
