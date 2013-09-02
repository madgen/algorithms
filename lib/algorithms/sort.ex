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

    @doc """
    Implementation for merge to be used in merge sort.
    It takes two sorted lists (in ascending order) and returns another list with elements from original lists in order.

    # Example
    
        merge([1,3,5],[2,3,4,5])
        #=> [1,2,3,3,4,5]

    """
    def merge(xs, []), do: xs
    def merge([], ys), do: ys
    def merge([x | xs], [y | ys]) do
      if x < y do
        [x | merge(xs, [y | ys])]
      else
        [y | merge([x | xs], ys)]
      end
    end

    @doc """
    Top down merge sort implementation of merge sort on lists.
    """
    def merge_sort([]),  do: []
    def merge_sort([x]), do: [x]
    def merge_sort(xs) do
      half = div length(xs), 2
      merge(
        xs |> Enum.take(half) |> merge_sort,
        xs |> Enum.drop(half) |> merge_sort
      )
    end
end
