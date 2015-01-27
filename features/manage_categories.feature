Feature: Manage Categories
  As a blog administrator
  In order to organize and catalog my articles
  I want to be able to manage categories for my blog

  Background:
    Given the blog is set up
    And I am logged into the admin panel as "admin"

  Scenario: Successfully navigate to categories
    Given I am on the admin dashboard page
    When I follow "Categories"
    Then I should be on the new category page

  Scenario: Successfully create categories
    Given I am on the new category page
    When I fill in "category_name" with "Foobar"
    And I fill in "category_keywords" with "fubar"
    And I fill in "category_description" with "Lorem Ipsum"
    And I press "Save"
    Then I should be on the new category page
    And I should see "Foobar"
    When I follow "Foobar"
    Then I should see "Lorem Ipsum"
