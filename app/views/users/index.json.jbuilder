json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :phone_no, :address, :customer_type, :nip
  json.url user_url(user, format: :json)
end
