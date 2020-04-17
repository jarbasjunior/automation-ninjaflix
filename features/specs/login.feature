Feature: Login

  As a user
  I want make to login with my e-mail and password
  For that I can manage the movies catalog in the Ninjaflix application

  Scenario: Access
    Given I login with 'tony@stark.com' and '123456'
    Then I must be authenticated
    And I must be see 'Tony Stark' in the logged area

  Scenario Outline: Invalid password
    Given I login with <email> and <password>
    Then I must not be authenticated
    And I must be see the alert message <message>

    Examples:
      | email                       | password | message                        |
      | 'tony@stark.com'            | 'skjdfa' | 'Usuário e/ou senha inválidos' |
      | 'user_not_exists@email.com' | '123456' | 'Usuário e/ou senha inválidos' |
      | ''                          | '123456' | 'Opps. Cadê o email?'          |
      | 'tony@stark.com'            | ''       | 'Opps. Cadê a senha?'          |
