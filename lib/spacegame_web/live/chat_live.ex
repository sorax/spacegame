defmodule SpacegameWeb.ChatLive do
  use Phoenix.LiveView

  alias SpacegameWeb.PageView

  alias Spacegame.Chat
  alias Spacegame.Chat.Message

  def mount(_session, socket) do
    if connected?(socket), do: Chat.subscribe()

    {:ok, fetch(socket)}
  end

  def render(assigns) do
    PageView.render("chat.html", assigns)
  end

  def fetch(socket, user_name \\ nil) do
    assign(socket, %{
      user_name: user_name,
      messages: Chat.list_messages(),
      changeset: Chat.change_message(%Message{username: user_name})
    })
  end

  def handle_event("validate", %{"message" => params}, socket) do
    changeset =
      %Message{}
      |> Chat.change_message(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("send_message", %{"message" => params}, socket) do
    case Chat.create_message(params) do
      {:ok, message} ->
        {:noreply, fetch(socket, message.username)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_event("delete_last", _, socket) do
    Chat.list_messages()
    |> List.last()
    |> Chat.delete_message()
    |> IO.inspect()

    {:noreply, socket}
  end

  def handle_info({Chat, [:message, _event_type], _message}, socket) do
    {:noreply, fetch(socket, get_user_name(socket))}
  end

  defp get_user_name(socket) do
    socket.assigns
    |> Map.get(:user_name)
  end
end
