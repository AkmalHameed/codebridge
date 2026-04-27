defmodule Codebridge.ApplicationsTest do
  use Codebridge.DataCase

  alias Codebridge.Applications

  describe "applications" do
    alias Codebridge.Applications.Application

    import Codebridge.ApplicationsFixtures

    @invalid_attrs %{module: nil, name: nil, status: nil, background: nil, email: nil, phone: nil, motivation: nil}

    test "list_applications/0 returns all applications" do
      application = application_fixture()
      assert Applications.list_applications() == [application]
    end

    test "get_application!/1 returns the application with given id" do
      application = application_fixture()
      assert Applications.get_application!(application.id) == application
    end

    test "create_application/1 with valid data creates a application" do
      valid_attrs = %{module: "some module", name: "some name", status: "some status", background: "some background", email: "some email", phone: "some phone", motivation: "some motivation"}

      assert {:ok, %Application{} = application} = Applications.create_application(valid_attrs)
      assert application.module == "some module"
      assert application.name == "some name"
      assert application.status == "some status"
      assert application.background == "some background"
      assert application.email == "some email"
      assert application.phone == "some phone"
      assert application.motivation == "some motivation"
    end

    test "create_application/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Applications.create_application(@invalid_attrs)
    end

    test "update_application/2 with valid data updates the application" do
      application = application_fixture()
      update_attrs = %{module: "some updated module", name: "some updated name", status: "some updated status", background: "some updated background", email: "some updated email", phone: "some updated phone", motivation: "some updated motivation"}

      assert {:ok, %Application{} = application} = Applications.update_application(application, update_attrs)
      assert application.module == "some updated module"
      assert application.name == "some updated name"
      assert application.status == "some updated status"
      assert application.background == "some updated background"
      assert application.email == "some updated email"
      assert application.phone == "some updated phone"
      assert application.motivation == "some updated motivation"
    end

    test "update_application/2 with invalid data returns error changeset" do
      application = application_fixture()
      assert {:error, %Ecto.Changeset{}} = Applications.update_application(application, @invalid_attrs)
      assert application == Applications.get_application!(application.id)
    end

    test "delete_application/1 deletes the application" do
      application = application_fixture()
      assert {:ok, %Application{}} = Applications.delete_application(application)
      assert_raise Ecto.NoResultsError, fn -> Applications.get_application!(application.id) end
    end

    test "change_application/1 returns a application changeset" do
      application = application_fixture()
      assert %Ecto.Changeset{} = Applications.change_application(application)
    end
  end
end
