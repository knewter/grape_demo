require 'spec_helper'

describe Acme::API do
  include Rack::Test::Methods

  def app
    Acme::API
  end
    
  context "v1" do
    it "get wines returns an empty collection" do
      get "/api/v1/wines"
      last_response.body.should == "[]"
    end
    it "post wines creates a wine" do
      wine_count = Wine.count
      post "/api/v1/wines?wine[name]=Malbec&wine[country]=France"
      Wine.count.should == wine_count + 1
      wine = Wine.last
      last_response.body.should == wine.to_json
      wine.name.should == "Malbec"
      wine.country.should == "France"
    end
    context "with a wine" do
      before :each do
        @wine = Fabricate :cabernet_sauvignon
      end
      it "get wines returns existing models" do
        get "/api/v1/wines"
        last_response.body.should == [ @wine ].to_json
      end
      it "get wine/:id returns a wine" do
        get "/api/v1/wines/#{@wine.id}"
        last_response.body.should == @wine.to_json        
      end
      it "put wine/:id updates a wine" do
        put "/api/v1/wines/#{@wine.id}?wine[country]=France"
        last_response.body.should == @wine.reload.to_json        
        @wine.country.should == "France"
      end
    end
  end
end

