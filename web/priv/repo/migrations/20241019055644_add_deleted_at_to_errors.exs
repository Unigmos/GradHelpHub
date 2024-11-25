defmodule GradHelpHubWeb.Repo.Migrations.AddDeletedAtToErrors do
  use Ecto.Migration

  def change do
    alter table(:errors) do
      add :deleted_at, :utc_datetime
    end
  end
end
