Feature: User Makes Order
  In order to have someone order lunch for me
  As a user
  I want to make order on the home page

  Scenario: Visitor Makes Order
    When Julius Caesar makes an order Caesar Salad with Balsamic Vinaigrette which has price $8.50
    Then Caesar Salad with Balsamic Vinaigrette which has price $8.5 under Julius Caesar should be in the order list

  Scenario: Return User Makes Order
    Given We have a user named Julius Caesar
    When  Julius Caesar makes an order Caesar Salad with Balsamic Vinaigrette which has price $8.5
    Then  We should have only one user named Julius Caesar
    And   Caesar Salad with Balsamic Vinaigrette which has price $8.5 under Julius Caesar should be in the order list

  Scenario: Visitor Orders Existing Item
    Given We have an item named Caesar Salad with Balsamic Vinaigrette which has price $8.5
    When  Julius Caesar makes an order Caesar Salad with Balsamic Vinaigrette which has price $8.5
    Then  We should have only one item named Caesar Salad with Balsamic Vinaigrette which has price $8.5
    And   Caesar Salad with Balsamic Vinaigrette which has price $8.5 under Julius Caesar should be in the order list