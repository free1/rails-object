json.data do
  json.array! @categories do |category|
    json.name category.name
    json.products category.products.last(8).map(&:list_json)
  end
end