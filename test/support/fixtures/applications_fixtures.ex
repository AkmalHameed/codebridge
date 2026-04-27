defmodule Codebridge.ApplicationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Codebridge.Applications` context.
  """

  @doc """
  Generate a application.
  """
  def application_fixture(attrs \\ %{}) do
    {:ok, application} =
      attrs
      |> Enum.into(%{
        background: "some background",
        email: "some email",
        module: "some module",
        motivation: "some motivation",
        name: "some name",
        phone: "some phone",
        status: "some status"
      })
      |> Codebridge.Applications.create_application()

    application
  end
end
