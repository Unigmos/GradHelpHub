defmodule GradHelpHubWeb.Schemas.Error do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  @derive {Jason.Encoder, only: [:id, :title, :language, :description, :cause, :solution, :inserted_at, :updated_at, :deleted_at]}
  schema "errors" do
    field :title, :string
    field :language, :string
    field :description, :string
    field :cause, :string
    field :solution, :string
    field :deleted_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(error, attrs) do
    error
    |> cast(attrs, [:title, :language, :description, :cause, :solution, :deleted_at])
    |> validate_required([:title])
  end

  # 論理削除関数
  def soft_delete(error) do
    changeset(error, %{deleted_at: DateTime.utc_now()})
  end

  # 未削除のデータ取得
  def not_deleted(query) do
    from e in query, where: is_nil(e.deleted_at)
  end
end
