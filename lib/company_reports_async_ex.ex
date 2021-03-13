alias CompanyReportsAsyncEx.Parser
alias CompanyReportsAsyncEx.DateUtils

defmodule CompanyReportsAsyncEx do
  @employees [
    "Daniele",
    "Mayk",
    "Giuliano",
    "Cleiton",
    "Jakeliny",
    "Joseph",
    "Diego",
    "Danilo",
    "Rafael",
    "Vinicius"
  ]

  def build(filename) do
    filename
    |> Parser.from_file()
    |> Enum.reduce(build_report_acc(), fn line, report -> sum_values(line, report) end)
  end

  def build_async(filenames) do
    result =
      filenames
      |> Task.async_stream(&build/1)
      |> Enum.reduce(build_report_acc(), fn {:ok, result}, report ->
        merge_reports(report, result)
      end)

    {:ok, result}
  end

  defp merge_reports(
         %{
           "all_hours" => new_hours,
           "hours_per_month" => new_months,
           "hours_per_year" => new_years
         },
         %{
           "all_hours" => final_hours,
           "hours_per_month" => final_months,
           "hours_per_year" => final_years
         }
       ) do
    all_hours = sum_maps(new_hours, final_hours)
    hours_per_month = sum_nested_map(new_months, final_months)
    hours_per_year = sum_nested_map(new_years, final_years)

    build_base_map(all_hours, hours_per_month, hours_per_year)
  end

  defp sum_maps(new_map, final_map) do
    Map.merge(new_map, final_map, fn _k, new, final -> safe_sum(new, final) end)
  end

  defp sum_nested_map(new_map, final_map) do
    Map.merge(new_map, final_map, fn _k, new, final ->
      sum_maps(new, final)
    end)
  end

  defp build_report_acc do
    all_hours = Enum.into(@employees, %{}, &{&1, 0})
    hours_per_month = Enum.into(@employees, %{}, &{&1, %{}})
    hours_per_year = Enum.into(@employees, %{}, &{&1, %{}})

    build_base_map(all_hours, hours_per_month, hours_per_year)
  end

  defp sum_values([name, hours, _day, month, year], %{
         "all_hours" => all_hours,
         "hours_per_month" => hours_per_month,
         "hours_per_year" => hours_per_year
       }) do
    month = DateUtils.get_month_string(month, "pt-BR")

    all_hours = Map.put(all_hours, name, all_hours[name] + hours)
    hours_per_month = sum_nested_values(hours_per_month, name, month, hours)
    hours_per_year = sum_nested_values(hours_per_year, name, year, hours)

    build_base_map(all_hours, hours_per_month, hours_per_year)
  end

  defp build_base_map(all_hours, hours_per_month, hours_per_year),
    do: %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    }

  def sum_nested_values(map, key, nested_key, value) do
    Map.put(
      map,
      key,
      Map.put(map[key], nested_key, safe_sum(map[key][nested_key], value))
    )
  end

  defp safe_sum(x, y) when is_nil(x), do: 0 + y
  defp safe_sum(x, y) when is_integer(x) when is_integer(y), do: x + y
end
