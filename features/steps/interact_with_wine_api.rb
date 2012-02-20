class InteractWithWineApi < Spinach::FeatureSteps
  feature 'Interact with wine API'

  When 'I post a new wine' do
    page.driver.post '/api/v1/wines', { name: 'Foo' }
  end

  Then 'it should be created' do
    page.driver.status_code.should == 201
  end
end
