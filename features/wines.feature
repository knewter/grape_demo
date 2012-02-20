Feature: Interact with wine API
  In order to CRUD wines
  As a backbone app
  I want to interact with the API

  Scenario: List wines
    When I post a new wine
    Then it should be created
