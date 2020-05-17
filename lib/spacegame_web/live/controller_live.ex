defmodule SpacegameWeb.ControllerLive do
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
    IO.inspect(deg)
    {:noreply, assign(socket, id: 0, team: 1, deg: deg)}
  end

  # @impl true
  # def handle_event("suggest", %{"q" => query}, socket) do
  #   {:noreply, assign(socket, results: search(query), query: query)}
  # end

  # @impl true
  # def handle_event("search", %{"q" => query}, socket) do
  #   case search(query) do
  #     %{^query => vsn} ->
  #       {:noreply, redirect(socket, external: "https://hexdocs.pm/#{query}/#{vsn}")}

  #     _ ->
  #       {:noreply,
  #        socket
  #        |> put_flash(:error, "No dependencies found matching \"#{query}\"")
  #        |> assign(results: %{}, query: query)}
  #   end
  # end

  # defp search(query) do
  #   if not SpacegameWeb.Endpoint.config(:code_reloader) do
  #     raise "action disabled when not in development"
  #   end

  #   for {app, desc, vsn} <- Application.started_applications(),
  #       app = to_string(app),
  #       String.starts_with?(app, query) and not List.starts_with?(desc, ~c"ERTS"),
  #       into: %{},
  #       do: {app, vsn}
  # end
end
