defmodule Pento.Survey.Rating.Query do
  import Ecto.Query

  def new, do: Rating

  def preload_user(user) do
    new()
    |> for_user(user)
  end

  def for_user(query, user) do
    query
    |> where([r], r.user_id == ^user.id)
  end
end
