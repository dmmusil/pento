defmodule PentoWeb.PromoLive do
  use PentoWeb, :live_view
  alias Pento.Promo
  alias Pento.Promo.Recipient

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_changeset()}
  end

  defp assign_changeset(socket) do
    socket
    |> assign(:changeset, Promo.change_recipient(%Recipient{}))
  end

  def handle_event(
        "validate",
        %{"recipient" => recipient_params},
        socket
      ) do
    changeset =
      %Recipient{}
      |> Promo.change_recipient(recipient_params)
      |> Map.put(:action, :validate)

    {:noreply, socket |> assign(:changeset, changeset)}
  end
end
