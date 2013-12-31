Feature: Customer Makes Order
  In order to have someone order lunch for me
  As a login user
  I want to make order on the home page

  Scenario: Customer Makes Order
    When  Julius Caesar makes an order Caesar Salad with Balsamic Vinaigrette which has price $8.5
    Then  Caesar Salad with Balsamic Vinaigrette which has price $8.5 under Julius Caesar should be in the order list

  Scenario: Customer Orders Existing Item
    Given We have an item named Caesar Salad with Balsamic Vinaigrette which has price $8.5
    When  Julius Caesar makes an order Caesar Salad with Balsamic Vinaigrette which has price $8.5
    Then  We should have only one item named Caesar Salad with Balsamic Vinaigrette which has price $8.5
    And   Caesar Salad with Balsamic Vinaigrette which has price $8.5 under Julius Caesar should be in the order list

  Scenario: Customer Sees His Order
    Given Julius Caesar makes an order Caesar Salad with Balsamic Vinaigrette which has price $8.5
    When  I log in as Julius Caesar
    Then  Caesar Salad with Balsamic Vinaigrette which has price $8.5 should be on home page

  Scenario: Customer Edits His Order
    Given Julius Caesar makes an order Caesar Salad with Balsamic Vinaigrette which has price $8.5
    When  Julius Caesar edits his order Caesar Salad with Buttermilk Ranch which has price $8.5
    Then  Caesar Salad with Buttermilk Ranch which has price $8.5 under Julius Caesar should be in the order list