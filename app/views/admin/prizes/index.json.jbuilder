json.array!(@prizes) do |prize|
  json.extract! mine, :id, :name
  json.url admin_prize_url(prize, format: :json)
end
