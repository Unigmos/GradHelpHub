defmodule GradHelpHubWeb.Repo.Migrations.CreateErrorsTable do
  use Ecto.Migration

  def change do
    create table(:errors) do
      add :title, :string, null: false
      add :language, :string
      add :description, :text
      add :cause, :text
      add :solution, :text

      timestamps()
    end
  end
end
