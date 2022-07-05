defmodule PentoWeb.DemographicLive.Form do
  use PentoWeb, :live_component
  alias Pento.Survey
  alias Pento.Survey.Demographics

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_demographic()
     |> assign_changeset()}
  end

  defp assign_demographic(%{assigns: %{current_user: current_user}} = socket) do
    assign(socket, :demographic, %Demographics{user_id: current_user.id})
  end

  defp assign_changeset(%{assigns: %{demographic: demographic}} = socket) do
    assign(socket, :changeset, Survey.change_demographics(demographic))
  end

  def handle_event("save", %{"demographics" => demographic_params}, socket) do
    {:noreply, save_demographic(socket, demographic_params)}
  end

  def handle_event("validate", %{"demographics" => demographic_params}, socket) do
    {:noreply,
     assign(socket,
       changeset:
         %Demographics{}
         |> Survey.change_demographics(demographic_params)
     )}
  end

  defp save_demographic(socket, demographic_params) do
    case Survey.create_demographics(demographic_params) do
      {:ok, demographic} ->
        send(self(), {:created_demographic, demographic})
        socket

      {:error, changeset} ->
        assign(socket, changeset: changeset)
    end
  end
end
