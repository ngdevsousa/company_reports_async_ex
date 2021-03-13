defmodule CompanyReportsAsyncExTest do
  use ExUnit.Case

  describe "build/1" do
    test "it should return a report based on the filename provided" do
      result =
        "test.csv"
        |> CompanyReportsAsyncEx.build()

      expected_result = %{
        "all_hours" => %{
          "Cleiton" => 1,
          "Daniele" => 12,
          "Danilo" => 0,
          "Diego" => 0,
          "Giuliano" => 9,
          "Jakeliny" => 0,
          "Joseph" => 0,
          "Mayk" => 5,
          "Rafael" => 0,
          "Vinicius" => 0
        },
        "hours_per_month" => %{
          "Cleiton" => %{"junho" => 1},
          "Daniele" => %{"abril" => 7, "dezembro" => 5},
          "Danilo" => %{},
          "Diego" => %{},
          "Giuliano" => %{"favereiro" => 9},
          "Jakeliny" => %{},
          "Joseph" => %{},
          "Mayk" => %{"dezembro" => 5},
          "Rafael" => %{},
          "Vinicius" => %{}
        },
        "hours_per_year" => %{
          "Cleiton" => %{"2020": 1},
          "Daniele" => %{"2016": 5, "2018": 7},
          "Danilo" => %{},
          "Diego" => %{},
          "Giuliano" => %{"2017": 3, "2019": 6},
          "Jakeliny" => %{},
          "Joseph" => %{},
          "Mayk" => %{"2017": 1, "2019": 4},
          "Rafael" => %{},
          "Vinicius" => %{}
        }
      }

      assert result == expected_result
    end
  end

  describe "build_async/1" do
    test "it should return a report based on the list of filenames provided" do
      result = CompanyReportsAsyncEx.build_async(["test_part_1.csv", "test_part_2.csv"])

      expected_result =
        {:ok,
         %{
           "all_hours" => %{
             "Cleiton" => 1,
             "Daniele" => 12,
             "Danilo" => 0,
             "Diego" => 0,
             "Giuliano" => 9,
             "Jakeliny" => 0,
             "Joseph" => 0,
             "Mayk" => 5,
             "Rafael" => 0,
             "Vinicius" => 0
           },
           "hours_per_month" => %{
             "Cleiton" => %{"junho" => 1},
             "Daniele" => %{"abril" => 7, "dezembro" => 5},
             "Danilo" => %{},
             "Diego" => %{},
             "Giuliano" => %{"favereiro" => 9},
             "Jakeliny" => %{},
             "Joseph" => %{},
             "Mayk" => %{"dezembro" => 5},
             "Rafael" => %{},
             "Vinicius" => %{}
           },
           "hours_per_year" => %{
             "Cleiton" => %{"2020": 1},
             "Daniele" => %{"2016": 5, "2018": 7},
             "Danilo" => %{},
             "Diego" => %{},
             "Giuliano" => %{"2017": 3, "2019": 6},
             "Jakeliny" => %{},
             "Joseph" => %{},
             "Mayk" => %{"2017": 1, "2019": 4},
             "Rafael" => %{},
             "Vinicius" => %{}
           }
         }}

      assert result == expected_result
    end
  end
end
