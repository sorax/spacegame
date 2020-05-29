defmodule SpacegameWeb.Eyeballpaul.ControllerLive do
  use SpacegameWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, id: 0, team: 1, deg: 100)}
  end

  #  <form phx-change="suggest" phx-submit="search">
  #    <input type="text" name="q" value="<%= @query %>" list="matches" placeholder="Search..."
  #           <%= if @loading, do: "readonly" %>/>
  #    <datalist id="matches">
  #      <%= for match <- @matches do %>
  #        <option value="<%= match %>"><%= match %></option>
  #      <% end %>
  #    </datalist>
  #    <%= if @result do %><pre><%= @result %></pre><% end %>
  #  </form>

  @impl true
  def handle_event("set_deg", %{"controller" => %{"deg" => deg}}, socket) do
    Phoenix.PubSub.broadcast(
      Spacegame.PubSub,
      "Eyeballpaul",
      {:set_deg, %{deg: String.to_integer(deg), id: socket.id}}
    )

    {:noreply, assign(socket, id: 0, team: 1, deg: deg)}
  end
end
