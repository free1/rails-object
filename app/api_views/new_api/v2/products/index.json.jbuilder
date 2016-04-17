json.data do
  json.products @products.map(&:list_json)
end