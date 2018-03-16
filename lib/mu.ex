defmodule Mu do
  @moduledoc """
  Documentation for Mu.
  """

  def start_server do
    Parser.Supervisor.start_link
    case File.rm("/tmp/mu.sock") do
      :ok -> IO.puts "Existing socket file removed"
      {:error, reason} -> IO.puts "Error #{reason}"
    end

    case :gen_tcp.listen(0, [{:ifaddr, {:local, "/tmp/mu.sock"}}, active: false]) do
      {:ok, listensocket} -> start_listening(listensocket)
      {:error, reason} -> IO.puts "Error #{reason}"
    end
  end

  def start_listening(listensocket) do
    case :gen_tcp.accept(listensocket) do
      {:ok, socket} -> read_socket(listensocket, socket)
      {:error, reason} -> IO.puts "Error: #{reason}"
    end
    start_listening(listensocket)
  end

  def read_socket(listensocket, socket) do
    case :gen_tcp.recv(socket, 0) do
      {:ok, packet} -> read_and_close(socket, to_string(packet))
      {:error, reason} -> IO.puts "Error: #{reason}"
    end
   start_listening(listensocket) 
  end

  def read_and_close(socket, packet) do
    Parser.parse(packet)
    :gen_tcp.close(socket)
  end
end

Mu.start_server()
