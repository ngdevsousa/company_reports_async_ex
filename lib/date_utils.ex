defmodule CompanyReportsAsyncEx.DateUtils do
  @en_us [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ]
  @pt_br [
    "janeiro",
    "favereiro",
    "março",
    "abril",
    "maio",
    "junho",
    "julho",
    "agosto",
    "setembro",
    "outubro",
    "novembro",
    "dezembro"
  ]

  @kinds ["pt-BR", "en-US"]

  def get_month_string(index, kind) when kind in @kinds and index >= 0 and index <= 12 do
    case kind do
      "en-US" -> Enum.at(@en_us, index - 1)
      "pt-BR" -> Enum.at(@pt_br, index - 1)
    end
  end

  def get_month_string(_index, _kind),
    do: {:error, "index must be between 1..12 and kind must be either 'pt-BR' or 'en-US'"}
end
