defmodule Algorithms do
    defmodule Math do

        @doc """
        Returns GCD of two (or more) integers, based on [Euclidean algorithm](https://en.wikipedia.org/wiki/Euclidean_algorithm)
        """
        def gcd([]) do
            0
        end

        def gcd([head|tail]) do
            :lists.foldl fn (first, second) -> gcd(first, second) end, head, tail
        end

        defp gcd(first, 0) do
            first
        end

        defp gcd(first, second) do
            gcd(second, rem(first, second))
        end

        @doc """
        Returns [LCM](http://en.wikipedia.org/wiki/Least_common_multiple) of two (or more) integers, based on GCD
        """
        def lcm([]) do
            0
        end

        def lcm([head|tail]) do
            :lists.foldl fn (first, second) -> lcm(first, second) end, head, tail
        end

        defp lcm(first, second) do
            div (first * second), gcd([first, second])
        end

        @doc """
        Returns [factorial](http://en.wikipedia.org/wiki/Factorial) for given integer
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

    end

    defmodule Sort do
        
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
        """
        def quick([]) do
            []
        end

        def quick([head|tail]) do
            # split list into two lists:
            {left, right} = Enum.partition tail, fn (x) -> x < head end
            quick(left) ++ [head] ++ quick(right)
        end

    end

    defmodule Search do
        
        @doc """
        Binary search algorithm.
        Returns index of value in list or -1 if list doesn't contains value
        """
        def binary(list, value) do
            binary(list, value, 1, length list)
        end
        
        defp binary(list, value, start, ends) do
            if start > ends do
                {:error, -1}
            else
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
    end
end
