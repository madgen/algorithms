defmodule Algorithms.Math do

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
        number * number
    end

end