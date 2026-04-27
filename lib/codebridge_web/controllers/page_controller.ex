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
end
