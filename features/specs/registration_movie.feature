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

  Scenario Outline: Required fields
    The catalog manager tries to register a new movie, but he forgets to fill some
    of requireds fields. Next, the system show displays a notification to the user

    Given that <code> is a new movie
    When I make the register this movie
    Then I must be see a <notification>

    Examples:
      | code              | notification                                    |
      | 'no_title'        | 'Oops - Filme sem título. Pode isso Arnaldo?'   |
      | 'no_status'       | 'Oops - O status deve ser informado!'           |
      | 'no_year'         | 'Oops - Faltou o ano de lançamento também!'     |
      | 'no_release_date' | 'Oops - Quase lá, só falta a data de estréia!' |

  Scenario: Duplicated
    Given that 'Deeadpool 2' already registered
    Then I must be see notification 'Oops - Esse título já existe no Ninjaflix.'
