Benchee.run(%{
  "build" => fn -> CompanyReportsAsyncEx.build("full.csv") end,
  "build_async" => fn ->
    CompanyReportsAsyncEx.build_async(["part_1.csv", "part_2.csv", "part_3.csv"])
  end
})
