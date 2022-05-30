defmodule Pento.Survey.Demographics.Query do
  import Ecto.Query
  alias Pento.Survey.Demographics

  def new() do
    Demographics
  end

  def for_user(query \\ new(), user) do
    query
    |> where([d], d.user_id == ^user.id)
  end
end
