Code.require_file "test_helper.exs", __DIR__

defmodule MathTest do
    use ExUnit.Case

    test "gcd" do
        numbers = [105, 70, 35, 15]
        result = Algorithms.Math.gcd numbers
        assert result == 5
    end

    test "empty_gcd" do
        numbers = []
        result = Algorithms.Math.gcd numbers
        assert result == 1
    end

    test "lcm" do
        numbers = [3, 4, 20]
        result = Algorithms.Math.lcm numbers
        assert result == 60
    end

    test "empty_lcm" do
        numbers = []
        result = Algorithms.Math.lcm numbers
        assert result == 1
    end

    test "factorial" do
        num = 5
        result = Algorithms.Math.factorial(num)
        assert result == 120
    end

    test "binary_pow" do
        first = 16
        second = 2
        result = Algorithms.Math.binpow(first, second)
        assert result == 256
        first = 8
        second = 8
        result = Algorithms.Math.binpow(first, second)
        assert result == 16777216
    end

    test "square" do
        number = 2
        result = Algorithms.Math.square number
        assert result == 4
    end

end

defmodule SortTest do
    use ExUnit.Case

    test "sleepsort" do
        numbers = [1, 2, 0, 10]
        result = Algorithms.Sort.sleep numbers
        assert result == [0, 1, 2, 10]
    end

    test "quicksort" do
        numbers = [12, 0, 1, 8, 10]
        result = Algorithms.Sort.quick numbers
        assert result == [0, 1, 8, 10, 12]
    end

end

defmodule SearchTest do
    use ExUnit.Case

    test "binary_search" do
        l = [22, 32, 42, 52, 62]
        {state, result} = Algorithms.Search.binary l, 52
        assert state == :ok
        assert result == 4
    end

    test "binary_search_error_handing" do
        l = [18, 28, 38]
        number = 1337
        {state, result} = Algorithms.Search.binary l, number
        assert state == :error
        assert result == -1
    end

    test "ne_item_binary_search" do
        l = [22, 32, 42, 52, 62]
        {state, result} = Algorithms.Search.binary l, 1337
        assert state == :error
        assert result == -1
    end

end

defmodule GraphTest do
    use ExUnit.Case

    test "create_graph" do
        graph = Algorithms.Graph.new(nodes: [1, 2, 3])
        assert graph.nodes == [1, 2, 3]
    end

    test "insert_node_to_graph" do
        node = Algorithms.Node.new(name: "Head")
        graph = Algorithms.Graph.new(nodes: [])
        {:ok, graph} = Algorithms.Graph.insert(graph, node)
        assert graph.nodes == node
    end

    test "insert_multiple_nodes" do
        first_node = Algorithms.Node.new(name: "Head")
        second_node = Algorithms.Node.new(name: "Tail")
        graph = Algorithms.Graph.new(nodes: [first_node, second_node])
        assert length(graph.nodes) == 2
    end

    test "remove_node_from_graph" do
        node = Algorithms.Node.new(name: "Head")
        graph = Algorithms.Graph.new(nodes: [node])
        {:ok, graph} = Algorithms.Graph.remove(graph, node)
        assert graph.nodes == []
    end
end
