Feature: display list of movies filtered by MPAA rating
 
  As a concerned parent
  So that I can quickly browse movies appropriate for my family
  I want to see movies matching only certain MPAA ratings

Background: movies have been added to database

  Given the following movies exist:
  | title                   | director           | rating | release_date |
  | Aladdin                 | Ron Clements       | G      | 25-Nov-1992  |
  | The Terminator          | James Cemeron      | R      | 26-Oct-1984  |
  | When Harry Met Sally    | Rob Reiner         | R      | 21-Jul-1989  |
  | The Help                | Tate Taylor        | PG-13  | 10-Aug-2011  |
  | Chocolat                | Lasse Hallström    | PG-13  | 5-Jan-2001   |
  | Amelie                  | Jean-Pierre Jeunet | R      | 25-Apr-2001  |
  | 2001: A Space Odyssey   | Stanley Kubrick    | G      | 6-Apr-1968   |
  | The Incredibles         | Brad Bird          | PG     | 5-Nov-2004   |
  | Raiders of the Lost Ark | Steven Spielberg   | PG     | 12-Jun-1981  |
  | Chicken Run             | Nick Park          | G      | 21-Jun-2000  |

  And  I am on the RottenPotatoes home page
  
Scenario: restrict to movies with 'PG' or 'R' ratings
  # enter step(s) to check the 'PG' and 'R' checkboxes
  When I check the following ratings: "PG, R"
  # enter step(s) to uncheck all other checkboxes
    And I uncheck the following ratings: "G, PG-13, NC-17"
  # enter step to "submit" the search form on the homepage
    And I press "ratings_submit"
  # enter step(s) to ensure that PG and R movies are visible
  Then I should see "The Incredibles"
  	And I should see "The Terminator"
  	And I should see "When Harry Met Sally"
  	And I should see "Amelie"
  	And I should see "Raiders of the Lost Ark"
  # enter step(s) to ensure that other movies are not visible
   And I should not see "The Help"
   And I should not see "2001: A Space Odyssey"
   And I should not see "Chicken Run"
   And I should not see "Chocolat"
   And I should not see "Aladdin"

Scenario: no ratings selected
 When I uncheck the following ratings: "PG, R, G, PG-13, NC-17"
  And I press "ratings_submit"
 Then I should not see all the movies  


Scenario: all ratings selected
 When I check the following ratings: "PG, R, G, PG-13, NC-17"
  And I press "ratings_submit"
 Then I should see all the movies