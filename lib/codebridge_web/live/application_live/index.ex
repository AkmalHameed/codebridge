defmodule CodebridgeWeb.ApplicationLive.Index do
  use CodebridgeWeb, :live_view

  alias Codebridge.Applications

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Listing Applications
        <:actions>
          <.button variant="primary" navigate={~p"/applications/new"}>
            <.icon name="hero-plus" /> New Application
          </.button>
        </:actions>
      </.header>

      <.table
        id="applications"
        rows={@streams.applications}
        row_click={fn {_id, application} -> JS.navigate(~p"/applications/#{application}") end}
      >
        <:col :let={{_id, application}} label="Name">{application.name}</:col>
        <:col :let={{_id, application}} label="Email">{application.email}</:col>
        <:col :let={{_id, application}} label="Phone">{application.phone}</:col>
        <:col :let={{_id, application}} label="Module">{application.module}</:col>
        <:col :let={{_id, application}} label="Background">{application.background}</:col>
        <:col :let={{_id, application}} label="Motivation">{application.motivation}</:col>
        <:col :let={{_id, application}} label="Status">{application.status}</:col>
        <:action :let={{_id, application}}>
          <div class="sr-only">
            <.link navigate={~p"/applications/#{application}"}>Show</.link>
          </div>
          <.link navigate={~p"/applications/#{application}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, application}}>
          <.link
            phx-click={JS.push("delete", value: %{id: application.id}) |> hide("##{id}")}
            data-confirm="Are you sure?"
          >
            Delete
          </.link>
        </:action>
      </.table>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Listing Applications")
     |> stream(:applications, list_applications())}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    application = Applications.get_application!(id)
    {:ok, _} = Applications.delete_application(application)

    {:noreply, stream_delete(socket, :applications, application)}
  end

  defp list_applications() do
    Applications.list_applications()
  end
end
