Code.require_file "test_helper.exs", __DIR__

defmodule AlgorithmsTest do
    use ExUnit.Case

    test "gcd" do
        numbers = [105, 70, 35, 15]
        result = Algorithms.Math.gcd numbers
        assert result == 5
    end

    test "empty_gcd" do
        numbers = []
        result = Algorithms.Math.gcd numbers
        assert result == 0
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
        result = Algorithms.Search.binary l, 52
        assert result == 4
    end

    test "ne_item_binary_search" do
        l = [22, 32, 42, 52, 62]
        result = Algorithms.Search.binary l, 1337
        assert result == -1
    end

    test "factorial" do
        num = 5
        result = Algorithms.Math.factorial(5)
        assert result == 120
    end

end
