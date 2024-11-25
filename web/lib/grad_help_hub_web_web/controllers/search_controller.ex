defmodule GradHelpHubWebWeb.SearchController do
  use GradHelpHubWebWeb, :controller
  import Ecto.Query

  alias GradHelpHubWeb.Repo
  alias GradHelpHubWeb.Schemas.{Error, UsableLibrary}

  def search(conn, %{"keyword" => keyword}) do
    errors = search_errors(keyword)
    usable_libraries = search_usable_libraries(keyword)

    # 検索結果をレスポンスとして返す
    json(conn, %{
      errors: errors,
      usable_libraries: usable_libraries
    })
  end

  defp search_errors(keyword) do
    from(e in Error,
      where: ilike(e.title, ^"%#{keyword}%") or ilike(e.description, ^"%#{keyword}%")
    )
    |> Repo.all()
  end

  defp search_usable_libraries(keyword) do
    from(u in UsableLibrary,
      where: ilike(u.title, ^"%#{keyword}%") or ilike(u.description, ^"%#{keyword}%")
    )
    |> Repo.all()
  end
end
