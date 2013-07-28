Code.require_file "test_helper.exs", __DIR__

defmodule AlgorithmsTest do
    use ExUnit.Case
    require Benchmark

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
        assert result == 0
    end

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

    test "factorial" do
        num = 5
        result = Algorithms.Math.factorial(num)
        assert result == 120
    end

    def get_benchmark_results(kw) do
        max = inspect(Keyword.get kw, :max)
        min = inspect(Keyword.get kw, :min)
        average = inspect(Keyword.get kw, :average)
        {max, min, average}
    end

    test "perfomance" do
        IO.puts "\nRunning perfomance tests..."
        numbers = :lists.seq(1, 1000)

        {max, min, avg} = get_benchmark_results(Benchmark.times 1000, do: Algorithms.Math.gcd(numbers))
        IO.puts "\n~> GCD for #{length numbers} numbers:"
        IO.puts "~| Max: #{max}\n~| Min: #{min}\n~| Average: #{avg}"

        {max, min, avg} = get_benchmark_results(Benchmark.times 1000, do: Algorithms.Search.binary(numbers, 18))
        IO.puts "\n~> Binary search in #{length numbers} numbers:"
        IO.puts "~| Max: #{max}\n~| Min: #{min}\n~| Average: #{avg}"
        
        numbers = Enum.reverse :lists.seq(1, 1000)

        {max, min, avg} = get_benchmark_results(Benchmark.times 1000, do: Algorithms.Math.lcm(numbers))
        IO.puts "\n~> LCM for #{length numbers} numbers:"
        IO.puts "~| Max: #{max}\n~| Min: #{min}\n~| Average: #{avg}"

        # {time, _} = :timer.tc(fn ->  end)
        # IO.puts "~>  numbers, time: #{time/1000} ms."
        # {time, result} = :timer.tc(fn -> Algorithms.Sort.sleep(numbers) end)
        # IO.puts "~> Sleep sort for #{length result} numbers, time: #{time/1000} ms."
        # {time, result} = :timer.tc(fn -> Algorithms.Sort.quick(numbers) end)
        # IO.puts "~> Quick sort for #{length result} numbers, time: #{time/1000} ms."
        # {time, result} = :timer.tc(fn -> Enum.map(numbers, fn (x) -> Algorithms.Math.binpow x, 10 end) end)
        # IO.puts "~> Binary exponentiation of #{length result} numbers, time: #{time/1000} ms."
        # {time, result} = :timer.tc(fn -> Enum.map(numbers, fn (x) -> :math.pow x, 10 end) end)
        # IO.puts "~> Native Erlang exponentiation of #{length result} numbers, time: #{time/1000} ms."
    end

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

    test "binary_pow_without_second_arg" do
        number = 16
        result = Algorithms.Math.binpow number
        assert result == 16
    end
end
