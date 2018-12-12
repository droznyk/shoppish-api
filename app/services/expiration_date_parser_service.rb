class ExpirationDateParserService
  def call(expiration_date)
    month, year = expiration_date.split('/').map(&:to_i)
    year = "20#{year}".to_i
    expiration_date = DateTime.new(year, month, -1)
  end
end
