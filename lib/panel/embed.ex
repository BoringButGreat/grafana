defmodule Grafana.Panel.Embed do
  @api_host Application.get_env(:grafana, :api_host)
  @username Application.get_env(:grafana, :username)
  @password Application.get_env(:grafana, :password)

  # model
  # <iframe src="http://xxx.xxx.xxx.xxx:3000/dashboard-solo/db/worldping-endpoint-ping?panel_id=1" width="450" height="200" frameborder="0"></iframe>
  defp build_src(uri, panel_id) do
    "#{@api_host}/dashboard-solo/db/#{uri}?panelId=#{panel_id}"
  end

  def get_html(uri, panel_id, width, height, border) do
    src = build_src uri, panel_id
    "<iframe src=\"#{src}\" width=\"#{width}\" height=\"#{height}\" frameborder=\"#{border}\"></iframe>"
  end

  def model(uri, panel_id, width, height, border) do
    src = build_src uri, panel_id
    %{src: src, width: width, height: height, frameborder: border}
  end
end
