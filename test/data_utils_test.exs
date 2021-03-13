defmodule CompanyReportsAsyncEx.DateUtilsTest do
  use ExUnit.Case

  alias CompanyReportsAsyncEx.DateUtils

  describe "get_month_string/1" do
    test "it should return a month in pt-BR based on the index and kind" do
      result = DateUtils.get_month_string(1, "pt-BR")
      expected_result = "janeiro"

      assert result == expected_result
    end

    test "it should return a month in en-US based on the index and kind" do
      result = DateUtils.get_month_string(1, "en-US")
      expected_result = "January"

      assert result == expected_result
    end

    test "it should return an error if an invalid number is provided" do
      result = DateUtils.get_month_string(13, "pt-BR")

      expected_result =
        {:error, "index must be between 1..12 and kind must be either 'pt-BR' or 'en-US'"}

      assert result == expected_result
    end

    test "it should return an error if an invalid kind is provided" do
      result = DateUtils.get_month_string(12, "foo-BAR")

      expected_result =
        {:error, "index must be between 1..12 and kind must be either 'pt-BR' or 'en-US'"}

      assert result == expected_result
    end
  end
end
