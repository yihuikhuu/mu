defmodule Mu.Monitor do
  def child_spec(_args) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_server, []}
    }
  end

  def start_server do
    case File.rm("/tmp/mu.sock") do
      :ok -> IO.puts("Existing socket file removed")
      {:error, reason} -> IO.puts("Error #{reason}")
    end

    case :gen_tcp.listen(0, [{:ifaddr, {:local, "/tmp/mu.sock"}}, active: false]) do
      {:ok, socket} -> loop(socket)
      {:error, reason} -> IO.puts("Error #{reason}")
    end
  end

  def loop(socket) do
    {:ok, client} = :gen_tcp.accept(socket)
    {:ok, pid} = Task.Supervisor.start_child(Mu.Monitor.TaskSupervisor, fn -> serve(client) end)
    :ok = :gen_tcp.controlling_process(client, pid)
    loop(socket)
  end

  def serve(client) do
    case :gen_tcp.recv(client, 0) do
      {:ok, data} -> 
        parse(to_string(data))
        serve(client)
      {:error, reason} -> :gen_tcp.close(client)
    end
  end

  def parse(packet) do
    Mu.Parser.parse(packet)
  end
end
