class API < Grape::API
  helpers APIHelpers
  helpers ErrorsHelper

  prefix 'api'

  format :json

  mount V1::Base

end
