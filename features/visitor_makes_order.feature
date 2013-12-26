Feature: Visitor Makes Order
  In order to have someone order lunch for me
  As a visitor
  I want to make order on the home page

  Scenario: Make Oder
    When Julius Caesar makes an order Caesar Salad with price $8.50
    Then Caesar Salad with price $8.5 under Julius Caesar should be in the order list