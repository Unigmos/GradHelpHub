defmodule GradHelpHubWeb.Repo.Migrations.CreateUsableLibraries do
  use Ecto.Migration

  def change do
    create table(:usable_libraries) do
      add :title, :string, null: false
      add :language, :string
      add :description, :text
      add :usable_flag, :boolean, default: false
      add :deleted_at, :utc_datetime

      timestamps()
    end
  end
end
