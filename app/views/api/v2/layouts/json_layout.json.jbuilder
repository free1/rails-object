json.result 'success'

r = JSON.parse(yield)
r.each{|k,v|
  json.set! k,v
}
