defmodule Codebridge.Applications.Application do
  use Ecto.Schema
  import Ecto.Changeset

  schema "applications" do
    field :name, :string
    field :email, :string
    field :phone, :string
    field :module, :string
    field :background, :string
    field :motivation, :string
    field :status, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(application, attrs) do
    application
    |> cast(attrs, [:name, :email, :phone, :module, :background, :motivation, :status])
    |> validate_required([:name, :email, :phone, :module, :background, :motivation, :status])
  end
end
