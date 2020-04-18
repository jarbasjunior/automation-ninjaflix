@login
Feature: Delete movie

  As a catalog manager movies
  I want to remove movies
  For them not to appear in the catalog

  Scenario: Confirm deletion
    Given that 'dbz' is of the catalog
    When I request deletion
    And I confirm deletion
    Then this item must be removed in the catalog

  Scenario: Give up deletion
    Given that '10 coisa que eu odeio em você' is of the catalog
    When I request deletion
    And I cancel deletion
    Then this item be remain in the catalog
  