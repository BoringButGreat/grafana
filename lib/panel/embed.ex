defmodule Grafana.Panel.Embed do
  @api_host Application.get_env(:grafana, :api_host)
  @username Application.get_env(:grafana, :username)
  @password Application.get_env(:grafana, :password)

  # model
  # <iframe src="http://xxx.xxx.xxx.xxx:3000/dashboard-solo/db/worldping-endpoint-ping?panelId=588&from=1462358038345&to=1462368778346&var-endpoint=boringbutgreat_com&var-probe=All&var-outliers=100" width="450" height="200" frameborder="0"></iframe>
  defp build_src(uri, panel_id, from, to, endpoint, probe, outliers) do
    "#{@api_host}/dashboard-solo/#{uri}?panelId=#{panel_id}&from=#{from}&to=#{to}&var-endpoint=#{endpoint}&var-probe=#{probe}&var-outliers=#{outliers}"
  end

  def get_html(uri, endpoint, from, to, width, height, border) do
    src = build_src uri, "588", from, to, endpoint, "All", "100"
    "<iframe src=\"#{src}\" width=\"#{width}\" height=\"#{height}\" frameborder=\"#{border}\"></iframe>"
  end
end
