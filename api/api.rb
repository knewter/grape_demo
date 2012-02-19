require './models/wine'
module Acme
  class API < Grape::API
    prefix 'api'
    version 'v1'

    resources :wines do
      desc "Returns some wines."
      get do
        Wine.all
      end

      desc "Get a specific wine's details"
      get ':id' do
        Wine.find(id)
      end

      desc "Update a wine"
      put ':id' do
        STDOUT.puts "---"
        STDOUT.puts "foo"
        STDOUT.puts "---"
        wine = Wine.find(id)
        wine.update_attributes(params)
        wine
      end
    end
  end
end
