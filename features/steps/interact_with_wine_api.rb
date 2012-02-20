class InteractWithWineApi < Spinach::FeatureSteps
  feature 'Interact with wine API'

  When 'I post a new wine' do
    page.driver.post '/api/v1/wines', { wine: { name: 'Foo' } }
  end

  Then 'it should be created' do
    page.driver.status_code.should == 201
    Wine.last.name.should == 'Foo'
  end
end
