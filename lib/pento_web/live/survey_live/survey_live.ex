defmodule PentoWeb.SurveyLive do
  use PentoWeb, :live_view

  alias PentoWeb.DemographicLive
  alias Pento.Survey
  alias Pento.Catalog
  alias PentoWeb.RatingLive

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_demographic
     |> assign_products}
  end

  defp assign_products(%{assigns: %{current_user: current_user}} = socket) do
    assign(socket, :products, Catalog.list_products_with_user_rating(current_user))
  end

  defp assign_demographic(%{assigns: %{current_user: current_user}} = socket) do
    assign(socket, :demographic, Survey.get_demographic_by_user(current_user))
  end

  def handle_info({:created_demographic, demographic}, socket) do
    {:noreply, handle_demographic_created(socket, demographic)}
  end

  def handle_info({:created_rating, product, product_index}, socket) do
    {:noreply, handle_rating_created(socket, product, product_index)}
  end

  defp handle_rating_created(
         %{assigns: %{products: products}} = socket,
         updated_product,
         product_index
       ) do
    socket
    |> put_flash(:info, "Rating submitted for #{updated_product.name}")
    |> assign(:products, List.replace_at(products, product_index, updated_product))
  end

  defp handle_demographic_created(socket, demographic) do
    socket
    |> put_flash(:info, "Demographic saved.")
    |> assign(demographic: demographic)
  end
end
