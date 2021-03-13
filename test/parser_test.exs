defmodule CompanyReportsAsyncEx.ParserTest do
  use ExUnit.Case

  alias CompanyReportsAsyncEx.Parser

  describe "from_file/1" do
    test "parse a file" do
      result =
        "test.csv"
        |> Parser.from_file()
        |> Enum.map(& &1)

      expected_result = [
        ["Daniele", 7, 29, 4, :"2018"],
        ["Mayk", 4, 9, 12, :"2019"],
        ["Daniele", 5, 27, 12, :"2016"],
        ["Mayk", 1, 2, 12, :"2017"],
        ["Giuliano", 3, 13, 2, :"2017"],
        ["Cleiton", 1, 22, 6, :"2020"],
        ["Giuliano", 6, 18, 2, :"2019"]
      ]

      assert result == expected_result
    end
  end
end
