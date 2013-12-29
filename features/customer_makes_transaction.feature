Feature: Customer Makes Transaction
  In order to record money transactions
  As a logged in customer
  I want to make transaction on transaction page

  Scenario: Make Transaction
    Given Julius Caesar has a balance of $-9.1
    And   Bo Liang has a balance of $9.1
    When  Bo Liang receives a transaction of $10 from Julius Caesar
    Then  Julius Caesar should have a balance of $0.9
    And   Bo Liang should have a balance of $-0.9