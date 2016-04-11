json.success 1

r = JSON.parse(yield)
r.each{|k,v|
  json.set! k,v
}
