Feature: Mock

  Scenario: Create a new mock
    When I open the "index" page
    And enter "{'hello':'world'}" into the "mock_body" field
    And click "Create mock now!"
    Then the page contains text "Mock created successfully"

