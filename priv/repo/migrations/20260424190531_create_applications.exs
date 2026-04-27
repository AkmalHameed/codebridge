defmodule Codebridge.Repo.Migrations.CreateApplications do
  use Ecto.Migration

  def change do
    create table(:applications) do
      add :name, :string
      add :email, :string
      add :phone, :string
      add :module, :string
      add :background, :text
      add :motivation, :text
      add :status, :string

      timestamps(type: :utc_datetime)
    end
  end
end
