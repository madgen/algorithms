defmodule Algorithms.Sort do

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