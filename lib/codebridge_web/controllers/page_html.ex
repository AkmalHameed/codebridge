defmodule CodebridgeWeb.PageHTML do
  use CodebridgeWeb, :html

  embed_templates "page_html/*"

  def status_color("accepted"), do: "#00ff88"
  def status_color("rejected"), do: "#ff006e"
  def status_color(_), do: "#00d9ff"
end
