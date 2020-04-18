@login
Feature: Registration Movie

  As a catalog manager
  I want register movier
  For them to appear in the catalog

  Scenario Outline: New Movie
    The catalog manager will to register a new movie through the form
    and a new movie is inserted in the Ninjaflix catalog

    Given that <code> is a new movie
    When I make the register this movie
    Then I must be see a new movie in the list

    Examples:
      | code       |
      | 'ultimato' |
      | 'spider'   |
      | 'jocker'   |

  Scenario: Without name
    When I try to register a movie without name
    Then I must be see the notification 'Oops - Filme sem título. Pode isso Arnaldo?'

  Scenario: Without status
    When I try to register a movie without status
    Then I must be see notification 'Oops - O status deve ser informado!'

  Scenario: Release year not informed
    Given I try to register a movie without release year
    Then I must be see notification 'Oops - Faltou o ano de lançamento também!'

  Scenario: Release date not informed
    Given I try to register a movie without release date
    Then I must be see notification 'Oops - Quase lá, só faltou a data de estréia!'

  Scenario: Duplicated
    Given that 'Deeadpool 2' already registered
    Then I must be see notification 'Oops - Esse título já existe no Ninjaflix.'
