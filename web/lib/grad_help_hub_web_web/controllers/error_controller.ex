defmodule GradHelpHubWebWeb.ErrorController do
  use GradHelpHubWebWeb, :controller

  alias GradHelpHubWeb.Repo
  alias GradHelpHubWeb.Schemas.Error

  # GET /api/errors
  def index(conn, _params) do
    errors = Repo.all(Error |> Error.not_deleted())
    json(conn, %{data: errors})
  end

  # POST /api/errors
  def create(conn, error_params) do
    changeset = Error.changeset(%Error{}, error_params)

    case Repo.insert(changeset) do
      {:ok, error} ->
        conn
        |> put_status(:created)
        |> json(%{data: error})

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: translate_errors(changeset)})
    end
  end

  # GET /api/errors/:id
  def show(conn, %{"id" => id}) do
    case Repo.get(Error, id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Error not found"})

      error ->
        json(conn, %{data: error})
    end
  end

  # PUT /api/errors/:id
  def update(conn, %{"id" => id} = params) do
    case Repo.get(Error, id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Error not found"})

      error ->
        changeset = Error.changeset(error, params["error"] || params)

        case Repo.update(changeset) do
          {:ok, _deleted_error} ->
            conn
            |> put_status(:ok)
            |> json(%{data: "Error Updated!"})

          {:error, changeset} ->
            conn
            |> put_status(:unprocessable_entity)
            |> json(%{errors: translate_errors(changeset)})
        end
    end
  end

  # DELETE /api/errors/:id
  def delete(conn, %{"id" => id}) do
    case Repo.get(Error, id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Error not found"})

      error ->
        changeset = Error.soft_delete(error)

        case Repo.update(changeset) do
          {:ok, _error} ->
            conn
            |> put_status(:no_content)
            |> send_resp(:no_content, "")

          {:error, _changeset} ->
            conn
            |> put_status(:unprocessable_entity)
            |> json(%{error: "Failed to delete error"})
        end
    end
  end

  # オプション: エラーメッセージのフォーマット
  defp translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
