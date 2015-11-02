if Rails.env.production?
  Elasticsearch::Model.client = Elasticsearch::Client.new(host: "localhost:9200")
  Elasticsearch::Model.client.transport.logger = Logger.new(STDERR)
else
  elasticsearch_configuration = {host: 'localhost', port: 9200}
  Elasticsearch::Model.client = Elasticsearch::Client.new(host: "localhost:9200")
  Elasticsearch::Model.client.transport.logger = Logger.new(STDERR)
end
