defmodule PentoWeb.SurveyLive.Component do
  use Phoenix.Component

  def hero(assigns) do
    ~H"""
    <h2>
      content: <%= @content %>
    </h2>

    <p>slot: <%= render_slot(@inner_block) %></p>
    """
  end
end
