Feature: Player can move around
  Scenario: Moving from one room to another
    Given I am in the Town Square
    When I move south
    Then I should be in the General Store
