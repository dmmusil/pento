defmodule Pento.SurveyFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pento.Survey` context.
  """

  @doc """
  Generate a demographics.
  """
  def demographics_fixture(attrs \\ %{}) do
    user = Pento.AccountsFixtures.user_fixture()

    {:ok, demographics} =
      attrs
      |> Enum.into(%{
        gender: "male",
        year_of_birth: 1984,
        user_id: user.id
      })
      |> Pento.Survey.create_demographics()

    demographics
  end

  @doc """
  Generate a rating.
  """
  def rating_fixture(attrs \\ %{}) do
    product = Pento.CatalogFixtures.product_fixture()
    user = Pento.AccountsFixtures.user_fixture()

    {:ok, rating} =
      attrs
      |> Enum.into(%{
        stars: 1,
        product_id: product.id,
        user_id: user.id
      })
      |> Pento.Survey.create_rating()

    rating
  end
end
