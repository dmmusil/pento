defmodule PentoWeb.WrongLive do
  use Phoenix.LiveView, layout: {PentoWeb.LayoutView, "live.html"}

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket, score: 0, message: "Make a guess:", secret: :rand.uniform(10) |> to_string())}
  end

  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @message %>
    </h2>
    <h2>
      <%= for n <- 1..10 do %>
        <a href="#" phx-click="guess" phx-value-number={n}><%= n %></a>
      <% end %>
    </h2>
    """
  end

  def handle_event("guess", %{"number" => guess} = _data, socket) do
    correct = guess == socket.assigns.secret

    message =
      if correct, do: "Correct!", else: "Your guess was wrong. You guessed #{guess}. Try again."

    score = if correct, do: socket.assigns.score + 10, else: socket.assigns.score - 1
    {:noreply, assign(socket, score: score, message: message)}
  end
end
