json.data do
  json.hot_products @hot_products.map(&:list_json)
  json.roll_nav_infos @roll_nav_infos.map(&:list_json)
end