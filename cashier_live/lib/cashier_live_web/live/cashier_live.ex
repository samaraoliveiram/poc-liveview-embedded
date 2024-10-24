defmodule CashierLiveWeb.CashierLive do
  use CashierLiveWeb, :live_view

  def render(assigns) do
    ~H"""
    <div data-value={@value} class="bg-gray-100 flex flex-col items-center justify-center h-40 w-40 data-[value='10']:bg-yellow-500 data-[value='20']:bg-red-500">
      <meta name="csrf-token" content={Plug.CSRFProtection.get_csrf_token()} />
      <h3 class="text-lg text-center text-blue-500">Current value:</h3>
      <p> <%= @value %> </p>
      <button phx-click="click"> Click me </button>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    IO.puts("mount")
    {:ok, assign(socket, value: 0 )}
  end

  def handle_event("click", _, socket) do
    IO.puts("click")
    value = socket.assigns.value
    {:noreply, assign(socket, value: value + 1)}
end
end
