json.data do
  json.array! @categories do |category|
    json.name category.name
    json.products category.products.map(&:list_json)
  end
end