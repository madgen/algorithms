defmodule Algorithms do

    @moduledoc """
    Collection of algorithms, inspired by nryoung/algorithms
    """

    defmodule Math do

        @moduledoc """
        Math related algorithms
        """

        @doc """
        Returns GCD of two (or more) integers, based on [Euclidean algorithm](https://en.wikipedia.org/wiki/Euclidean_algorithm)


        # Example

            numbers = [10, 20]
            gcd = Algorithms.Math.gcd numbers
            IO.puts gcd
            #=> 10

            numbers = [10, 20, 25]
            gcd = Algorithms.Math.gcd numbers
            IO.puts gcd
            #=> 5

        """
        def gcd([]) do
            1
        end

        def gcd([head|tail]) do
            :lists.foldl gcd(&1, &2), head, tail
        end

        defp gcd(first, 0) do
            first
        end

        defp gcd(first, second) do
            gcd(second, rem(first, second))
        end

        @doc """
        Returns [LCM](http://en.wikipedia.org/wiki/Least_common_multiple) of two (or more) integers, based on GCD

        # Example
            numbers = [4, 6]
            result = Algorithms.Math.lcm numbers
            IO.puts result
            #=> 12

        """
        def lcm([]) do
            1
        end

        def lcm([head|tail]) do
            :lists.foldl lcm(&1, &2), head, tail
        end

        defp lcm(first, second) do
            div (first * second), gcd([first, second])
        end

        @doc """
        Returns [factorial](https://en.wikipedia.org/wiki/Factorial) for given integer

        # Example
            number = 5
            fac = Algorithms.Math.factorial number
            IO.puts fac
            #=> 120

        """
        def factorial(first) do
            factorial(first - 1, first)
        end

        defp factorial(1, second) do
            second
        end

        defp factorial(first, second) do
            factorial(first - 1, second * first)
        end

        @doc """
        Performs binary exponentiation on given number.
        Note: it's a bad implementation. Use built-in Erlang math:pow.
        """

        def binpow(_, 0) do
            1
        end

        def binpow(first, second) when rem(second, 2) == 1 do
            binpow(first, second - 1) * first
        end

        def binpow(first, second) do
            third = binpow(first, div(second, 2))
            third * third
        end

        @doc """
        Returns square for given integer. Dummy function for testing :)
        """
        def square(number) do
            number * 2
        end

    end

    defmodule Sort do

        @moduledoc """
        Sorting related algorithms
        """
        
        @doc """
        Sleep sorting, based on [StepanKuzmin snippet](https://gist.github.com/StepanKuzmin/3866474)
        """
        def sleep([]) do
            []
        end

        def sleep(list) do
            pid = self
            pids = Enum.map list, fn (x) -> spawn fn -> pid <- wait x end end
            sleep([], pids)
        end

        defp sleep(list, []) do
            Enum.reverse list
        end

        defp sleep(list, pids) do
            receive do
                {:ok, pid, num} -> sleep [num | list], pids -- [pid] 
            end
        end

        defp wait(num) do
            pid = self
            :timer.sleep num
            {:ok, pid, num}
        end

        @doc """
        Performs quicksort on list, based on [edgurgel snippet](https://coderwall.com/p/vusjtq)


        # Example

            numbers = [3, 2, 5, 1, 4]
            sorted_numbers = Algorithms.Sort.quick numbers
            IO.puts sorted_numbers
            #=> [1, 2, 3, 4, 5]

        """
        def quick([]) do
            []
        end

        def quick([head|tail]) do
            {left, right} = Enum.partition tail, &1 < head
            quick(left) ++ [head] ++ quick(right)
        end
    end

    defmodule Search do

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
    end

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

    # def dfs(graph, start, path) do

    # end
end
