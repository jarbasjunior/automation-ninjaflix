Feature: Login

  As a user
  I want make to login with my e-mail and password
  For that I can manage the movies catalog in the Ninjaflix application

  @tmp
  Scenario: Access
    Given I login with 'tony@stark.com' and '123456'
    Then I must be authenticated
    And I must be see 'Tony Stark' in the logged area

  Scenario: Invalid password
    Given I login with 'tony@stark.com' and 'asdfgh'
    Then I must not be authenticated
    And I must be see the alert message 'Usuário e/ou senha inválidos.'

  Scenario: User not exists
    Given I login with 'user_not_exists@email.com' and '123456'
    Then I must not be authenticated
    And I must be see the alert message 'Usuário e/ou senha inválidos.'

  Scenario: E-mail not provided
    Given I login with '' and '123456'
    Then I must not be authenticated
    And I must be see the alert message 'Opps. Cadê o email?'

  Scenario: Password not provided
    Given I login with 'tony@stark.com' and ''
    Then I must be not authenticated
    And I must be see the alert message 'Opps. Cadê a senha?'
