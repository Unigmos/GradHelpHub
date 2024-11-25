defmodule GradHelpHubWebWeb.UsableLibraryController do
  use GradHelpHubWebWeb, :controller

  alias GradHelpHubWeb.Repo
  alias GradHelpHubWeb.Schemas.UsableLibrary

  # GET /api/usable_libraries
  def index(conn, _params) do
    libraries = Repo.all(UsableLibrary |> UsableLibrary.not_deleted())
    json(conn, %{data: libraries})
  end

  # POST /api/usable_libraries
  def create(conn, library_params) do
    changeset = UsableLibrary.changeset(%UsableLibrary{}, library_params)

    case Repo.insert(changeset) do
      {:ok, library} ->
        conn
        |> put_status(:created)
        |> json(%{data: library})

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: translate_errors(changeset)})
    end
  end

  # GET /api/usable_libraries/:id
  def show(conn, %{"id" => id}) do
    case Repo.get(UsableLibrary, id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Library not found"})

      library ->
        json(conn, %{data: library})
    end
  end

  # PUT /api/usable_libraries/:id
  def update(conn, %{"id" => id} = params) do
    case Repo.get(UsableLibrary, id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Library not found"})

      library ->
        changeset = UsableLibrary.changeset(library, params["usable_library"] || params)

        case Repo.update(changeset) do
          {:ok, updated_library} ->
            conn
            |> put_status(:ok)
            |> json(%{data: updated_library})

          {:error, changeset} ->
            conn
            |> put_status(:unprocessable_entity)
            |> json(%{errors: translate_errors(changeset)})
        end
    end
  end

  # DELETE /api/usable_libraries/:id
  def delete(conn, %{"id" => id}) do
    case Repo.get(UsableLibrary, id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Library not found"})

      library ->
        changeset = UsableLibrary.soft_delete(library)

        case Repo.update(changeset) do
          {:ok, _deleted_library} ->
            conn
            |> put_status(:no_content)
            |> json(%{data: "Library has been soft deleted"})

          {:error, changeset} ->
            conn
            |> put_status(:unprocessable_entity)
            |> json(%{errors: translate_errors(changeset)})
        end
    end
  end

  # エラーメッセージのフォーマット
  defp translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
