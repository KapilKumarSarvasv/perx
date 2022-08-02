json.extract! product, :id, :name, :amount, :country, :created_at, :updated_at
json.url product_url(product, format: :json)
