defmodule CodebridgeWeb.ApplicationLive.Form do
  use CodebridgeWeb, :live_view

  alias Codebridge.Applications
  alias Codebridge.Applications.Application

  def mount(_params, _session, socket) do
    changeset = Applications.change_application(%Application{})

    {:ok, assign(socket,
      application: %Application{},
      form: to_form(changeset),
      page_title: "Apply to CodeBridge"
    )}
  end

  def handle_event("validate", %{"application" => params}, socket) do
    changeset =
      socket.assigns.application
      |> Applications.change_application(params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, form: to_form(changeset))}
  end

  def handle_event("save", %{"application" => params}, socket) do
    params_with_status = Map.put(params, "status", "pending")

    case Applications.create_application(params_with_status) do
      {:ok, _application} ->
        {:noreply,
         socket
         |> redirect(to: "/?success=true")}

      {:error, changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  def render(assigns) do
    ~H"""
    <section class="page-hero">
      <div class="container">
        <h1>Apply to <span class="gradient-text">CodeBridge</span></h1>
        <p>Take the first step toward your AI career.</p>
      </div>
    </section>

    <section style="padding: 4rem 0;">
      <div class="container">
        <div class="form-section">
          <.form for={@form} phx-change="validate" phx-submit="save">
            <div class="form-group">
              <label>Full Name</label>
              <.input field={@form[:name]} type="text" placeholder="Your full name" />
            </div>
            <div class="form-group">
              <label>Email Address</label>
              <.input field={@form[:email]} type="email" placeholder="your@email.com" />
            </div>
            <div class="form-group">
              <label>Phone Number</label>
              <.input field={@form[:phone]} type="text" placeholder="+1 (555) 000-0000" />
            </div>
            <div class="form-group">
              <label>Which Module are you applying for?</label>
              <.input field={@form[:module]} type="select" options={["Module 01 - AI Foundations", "Module 02 - AI Specialization"]} />
            </div>
            <div class="form-group">
              <label>Your Background</label>
              <.input field={@form[:background]} type="textarea" placeholder="Tell us about your current background and experience..." />
            </div>
            <div class="form-group">
              <label>Why do you want to join CodeBridge?</label>
              <.input field={@form[:motivation]} type="textarea" placeholder="Tell us what motivates you to join this program..." />
            </div>
            <div style="margin-top: 2rem;">
              <button type="submit" class="cta-button">Submit Application</button>
            </div>
          </.form>
        </div>
      </div>
    </section>
    """
  end
end
