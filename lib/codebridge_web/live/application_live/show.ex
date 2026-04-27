defmodule CodebridgeWeb.ApplicationLive.Show do
  use CodebridgeWeb, :live_view

  alias Codebridge.Applications

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Application {@application.id}
        <:subtitle>This is a application record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/applications"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/applications/#{@application}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit application
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Name">{@application.name}</:item>
        <:item title="Email">{@application.email}</:item>
        <:item title="Phone">{@application.phone}</:item>
        <:item title="Module">{@application.module}</:item>
        <:item title="Background">{@application.background}</:item>
        <:item title="Motivation">{@application.motivation}</:item>
        <:item title="Status">{@application.status}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Show Application")
     |> assign(:application, Applications.get_application!(id))}
  end
end
