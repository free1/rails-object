json.data do
  json.products @products.map(&:list_json)

  json.meta do
    json.total_pages  @products.total_pages
    json.current_page @products.current_page
  end
end