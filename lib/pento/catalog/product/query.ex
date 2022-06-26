defmodule Pento.Catalog.Product.Query do
  import Ecto.Query

  alias Pento.Survey.Rating

  def new, do: Product

  def with_user_ratings(user) do
    new()
    |> preload_user_ratings(user)
  end

  def preload_user_ratings(query, user) do
    rating_query = Rating.Query.preload_user(user)

    query
    |> preload(ratings: ^rating_query)
  end
end
