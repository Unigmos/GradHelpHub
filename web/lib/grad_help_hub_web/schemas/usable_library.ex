defmodule GradHelpHubWeb.Schemas.UsableLibrary do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  @derive {Jason.Encoder, only: [:id, :title, :language, :description, :usable_flag, :inserted_at, :updated_at, :deleted_at]}
  schema "usable_libraries" do
    field :title, :string
    field :language, :string
    field :description, :string
    field :usable_flag, :boolean, default: false
    field :deleted_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(usable_library, attrs) do
    usable_library
    |> cast(attrs, [:title, :language, :description, :usable_flag, :deleted_at])
    |> validate_required([:title])
  end

  # 論理削除関数
  def soft_delete(usable_library) do
    changeset(usable_library, %{deleted_at: DateTime.utc_now()})
  end

  # 未削除のデータ取得
  def not_deleted(query) do
    from ul in query, where: is_nil(ul.deleted_at)
  end
end
