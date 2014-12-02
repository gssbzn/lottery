json.array!(@prizes) do |prize|
  json.extract! prize, :id, :name
  json.url admin_prize_url(prize, format: :json)
end
