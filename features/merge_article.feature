Feature: Merge Articles
  As a blog administrator
  In order to avoid duplicate articles
  I want to be able to merge articles in my blog

  Background:
    Given the blog is set up
    And the following users exist:
      | login | password | email                  | profile_id | name   | state  |
    # | admin | aaaaaaaa | admin@cloud-stack.host | 1          | admin  | active |
      | jody  | aaaaaaaa | jody@cloud-stack.host  | 2          | jody   | active |
      | john  | aaaaaaaa | john@cloud-stack.host  | 3          | john   | active |
    And the following articles exist
      | title                           | author | user_id | published | body                | allow_comments |
      | Article1                        | jody   | 2       | true      | Article 1 by User 2 | true           |
      | Article2                        | john   | 3       | true      | Article 2 by User 3 | true           |
    And the following comments exist
      | user_id | article  | published | body                             | state | status_confirmed |
      | 3       | Article2 | true      | Comment 1 on Article 2 by User 3 | ham   | true             |
      | 2       | Article1 | true      | Comment 1 on Article 1 by User 2 | ham   | true             |

  Scenario: I should see both articles on the manage articles page
    Given I am logged into the admin panel as "admin"
    When I go to the manage articles page
    Then I should see "Article1"
    And I should see "Article2"

  Scenario: When I edit an article, I should see the Merge Articles form
    Given I am logged into the admin panel as "admin"
    When I go to the manage articles page
    And I follow "Article1"
    Then I should see "Merge Articles"
    And I should see an element "#merge_with"

  Scenario: A non-admin cannot merge two articles
    Given I am logged into the admin panel as "jody"
    When I go to the manage articles page
    And I follow "Article1"
    Then I should not see "Merge Articles"

  Scenario: When I create a new article I should not see the Merge Articles form
    Given I am logged into the admin panel as "admin"
    When I go to the manage articles page
    And I go to the new article page
    Then I should not see "Merge Articles"

  Scenario: When articles are merged, the merged article should contain the text of both previous articles
    Given I am logged into the admin panel as "admin"
    When I go to the manage articles page
    And I follow "Article1"
    And I fill in "merge_with" with the id of the "Article2" article
    And I press "Merge"
    #Then I should see "An Article About Something"
    Then I should see "Article 1 by User 2"
    And I should see "Article 2 by User 3"

  Scenario: When articles are merged, the merged article should contain the comments of both previous articles
    Given I am logged into the admin panel as "admin"
    When I go to the manage articles page
    And I follow "Article1"
    And I fill in "merge_with" with the id of the "Article2" article
    And I press "Merge"
    And I go to the article view of "Article1"
    And show me the page
    Then I should see "Comment 1 on Article 2 by User 3"
    And I should see "Comment 1 on Article 1 by User 2"

