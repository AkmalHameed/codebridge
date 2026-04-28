defmodule CodebridgeWeb.PageController do
  use CodebridgeWeb, :controller

  alias Codebridge.Applications

  def home(conn, _params) do
    render(conn, :home)
  end

  def program(conn, _params) do
    render(conn, :program)
  end

  def curriculum(conn, _params) do
    render(conn, :curriculum)
  end

  def requirements(conn, _params) do
    render(conn, :requirements)
  end

  def module1(conn, _params) do
    render(conn, :module1)
  end

  def module2(conn, _params) do
    render(conn, :module2)
  end

  def admin(conn, _params) do
    applications = Applications.list_applications()
    render(conn, :admin, applications: applications)
  end

  def admin_show(conn, %{"id" => id}) do
    application = Applications.get_application!(id)
    render(conn, :admin_show, application: application)
  end

  def admin_review(conn, %{"id" => id}) do
    application = Applications.get_application!(id)
    Applications.update_application(application, %{status: "reviewed"})

    conn
    |> put_flash(:info, "Application marked as reviewed!")
    |> redirect(to: "/admin/#{id}")
  end
end
