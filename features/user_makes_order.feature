Feature: User Makes Order
  In order to have someone order lunch for me
  As a user
  I want to make order on the home page

  Scenario: Visitor Make Order
    When Julius Caesar makes an order Caesar Salad with price $8.50
    Then Caesar Salad with price $8.5 under Julius Caesar should be in the order list

  Scenario: Return User Make Order
    Given Julius Caesar has a balance of $-6.95
    When  Julius Caesar makes an order Caesar Salad with price $8.5
    Then  We should have only one user named Julius Caesar
    And   Caesar Salad with price $8.5 under Julius Caesar should be in the order list