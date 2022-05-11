defmodule HelloPhxBulma.Countdown do
  @spec calculate_time_remaining(DateTime.t()) :: integer
  def calculate_time_remaining(%DateTime{} = expiration_time) do
    DateTime.diff(expiration_time, DateTime.utc_now())
  end

  @spec humanize_seconds(integer) :: String.t() | {:error, any}
  def humanize_seconds(seconds) when is_integer(seconds) do
    seconds
    |> Timex.Duration.from_seconds()
    |> Timex.format_duration(:humanized)
  end

  @spec humanize_time_remaining(integer, keyword) :: binary
  def humanize_time_remaining(time_remaining, opts \\ [])

  def humanize_time_remaining(time_remaining, opts) when time_remaining > 0 do
    suffix = opts[:suffix] || " left"
    humanize_seconds(time_remaining) <> suffix
  end

  def humanize_time_remaining(_, opts), do: opts[:expiration_text] || "Expired"
end
