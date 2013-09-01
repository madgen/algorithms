defmodule Algorithms.Search do

    @moduledoc """
    Search related algorithms
    """
    
    @doc """
    Binary search algorithm.
    Returns index of value in list or -1 if list doesn't contains value


    # Example

        numbers = [28, 17, 42]

        # Existing number
        {:ok, index} = Algorithms.Search.binary numbers, 17
        IO.puts index
        #=> 2

        {:error, index} = Algorithms.Search.binary numbers 1337
        IO.puts index
        #=> -1

    """

    def binary([], _) do
        {:error, -1}
    end

    def binary(list, value) do
        binary(list, value, 1, length list)
    end

    defp binary(_, _, start, ends) when start > ends do
        {:error, -1}
    end

    defp binary(list, value, start, ends) do
        mid = div (start + ends), 2
        item = :lists.nth mid, list
        cond do
            value < item ->
                binary(list, value, start, mid - 1)
            value > item ->
                binary(list, value, mid + 1, ends)
            true ->
                {:ok, mid}
        end
    end

    @doc """
    Deep-first search
    """
    def dfs(node, goal, path) when is_record(node, Algorithms.Node) do
      path = path ++ [node]
      if node == goal do
        {:ok, node, path}
      else
        dfs(node.nodes, goal, path)
      end
    end

    def dfs([head|tail], goal, path) do
      case dfs(head, goal, path) do
        {:ok, node, path} -> {:ok, node, path}
        _ -> dfs(tail, goal, path)
      end
    end

    def dfs([], goal, path) do
      {:error, goal}
    end

    def dfs(graph, goal) when is_record(graph, Algorithms.Graph) do
      dfs(graph.nodes, goal, [])
    end

end