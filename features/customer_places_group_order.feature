Feature: Customer Places Group Order

  Scenario: Place Group Order
    Given Julius Caesar makes an order Caesar Salad with price $8.50
    And   Bo Liang makes an order Pad Thai with price $8.95
    When  Bo Liang places a group order with total $18.68
    Then  Julius Caesar should have $-9.1 as balance
    And   Bo Liang should have $9.1 as balance
    And   Caesar Salad with price $8.5 under Julius Caesar should not be in the order list