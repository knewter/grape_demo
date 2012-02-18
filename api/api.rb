require './models/wine'
module Acme
  class API < Grape::API
    prefix 'api'
    version 'v1'

    resource :wines do
      desc "Returns some wines."
      get do
        Wine.all
      end

      get ':id' do
        Wine.find(id)
      end
    end
  end
end
