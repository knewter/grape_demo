require './models/wine'
module Acme
  class API < Grape::API
    prefix 'api'
    version 'v1', :using => :path

    resources :wines do
      desc "Returns some wines."
      get do
        Wine.all.as_json
      end

      desc "Get a specific wine's details"
      get ':id' do
        Wine.find(params[:id]).as_json
      end

      desc "Update a wine"
      put ':id' do
        wine = Wine.find(params[:id])
        wine.update_attributes!(params['wine'])
        wine.as_json
      end
      
      desc "Create a wine"
      post '/' do
        puts "params: #{params}"
        wine = Wine.create!(params['wine'])
        wine.as_json
      end
    end
  end
end
