defmodule Algorithms do
    defmodule Math do

        @doc """
        Returns GCD of two (or more) integers, based on Euclidean algorithm
        https://en.wikipedia.org/wiki/Euclidean_algorithm
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

        def lcm([]) do
            0
        end

        def lcm([head|tail]) do
            :lists.foldl fn (first, second) -> lcm(first, second) end, head, tail
        end

        defp lcm(first, second) do
            div (first * second), gcd([first, second])
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
                -1
            else
                mid = div (start + ends), 2
                item = :lists.nth mid, list
                cond do
                    value < item ->
                        binary(list, value, start, mid - 1)

                    value > item ->
                        binary(list, value, mid + 1, ends)

                    true ->
                        mid
                end
            end
        end
    end
end