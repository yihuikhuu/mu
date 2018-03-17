defmodule Mu do
  @moduledoc """
  Documentation for Mu.
  """

  def start_server do
    IO.inspect(Parser.Supervisor.start_link())

    case File.rm("/tmp/mu.sock") do
      :ok -> IO.puts("Existing socket file removed")
      {:error, reason} -> IO.puts("Error #{reason}")
    end

    case :gen_tcp.listen(0, [{:ifaddr, {:local, "/tmp/mu.sock"}}, active: false]) do
      {:ok, listen_socket} -> start_listening(listen_socket)
      {:error, reason} -> IO.puts("Error #{reason}")
    end
  end

  def start_listening(listen_socket) do
    case :gen_tcp.accept(listen_socket) do
      {:ok, socket} -> read_socket(listen_socket, socket)
      {:error, reason} -> IO.puts("Error: #{reason}")
    end

    start_listening(listen_socket)
  end

  def read_socket(listen_socket, socket) do
    case :gen_tcp.recv(socket, 0) do
      {:ok, packet} -> read_and_close(socket, to_string(packet))
      {:error, reason} -> IO.puts("Error: #{reason}")
    end

    start_listening(listen_socket)
  end

  def read_and_close(socket, packet) do
    Parser.parse(packet)
    :gen_tcp.close(socket)
  end
end

Mu.start_server()
