defmodule Algorithms do

    @moduledoc """
    Collection of algorithms, inspired by nryoung/algorithms
    """

    defrecord Graph, nodes: [] do

        @doc """
        Inserts given node to graph. Returns state (`:ok`) and new graph record.
        """

        def insert(graph, []) do
            {:ok, graph}
        end

        def insert(graph, [head|tail]) do
            {:ok, graph} = insert(graph, head)
            insert(graph, tail)
        end

        def insert(graph, node) do
            nodes = graph.nodes ++ [node]
            {:ok, Graph.new(nodes: nodes)}
        end

        @doc """
        Removes given node from graph. As `insert` function, returns state and new graph.
        """

        def remove(graph, []) do
            {:ok, graph}
        end

        def remove(graph, [head|tail]) do
            {:ok, graph} = remove(graph, head)
            remove(graph, tail)
        end

        def remove(graph, node) do
            nodes = graph.nodes -- [node]
            {:ok, Graph.new(nodes: nodes)}
        end

    end

    defrecord Node, name: nil, nodes: [] do

        def insert(parent, []) do
            {:ok, parent}
        end

        def insert(parent, [head|tail]) do
            {:ok, parent} = insert(parent, head)
            insert(parent, tail)
        end

        def insert(parent, node) do
            nodes = parent.nodes ++ [node]
            {:ok, Node.new(name: parent.name, nodes: nodes)}
        end

        def remove(parent, []) do
            {:ok, parent}
        end

        def remove(parent, [head|tail]) do
            {:ok, parent} = remove(parent, head)
            remove(parent, tail)
        end

        def remove(parent, node) do
            nodes = parent.nodes -- node
            {:ok, Node.new(name: parent.name, nodes: nodes)}
        end

    end
end
