defmodule Pento.Survey.Rating.Query do
  import Ecto.Query

  alias Pento.Survey.Rating

  def new, do: Rating

  def preload_user(user) do
    new()
    |> for_user(user)
  end

  def for_user(query, user) do
    IO.inspect(user.id)

    query
    |> where([r], r.user_id == ^user.id)
  end
end
