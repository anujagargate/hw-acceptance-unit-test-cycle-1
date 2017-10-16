Feature: display list of movies sorted by different criteria
 
  As an avid moviegoer
  So that I can quickly browse movies based on my preferences
  I want to see movies sorted by title or release date

Background: movies have been added to database
  
  Given the following movies exist:
  | title                   | director           | rating | release_date |
  | Aladdin                 | Ron Clements       | G      | 25-Nov-1992  |
  | The Terminator          | James Cameron      | R      | 26-Oct-1984  |
  | When Harry Met Sally    | Rob Reiner         | R      | 21-Jul-1989  |
  | The Help                | Tate Taylor        | PG-13  | 10-Aug-2011  |
  | Chocolat                | Lasse Hallström    | PG-13  | 5-Jan-2001   |
  | Amelie                  | Jean-Pierre Jeunet | R      | 25-Apr-2001  |
  | 2001: A Space Odyssey   | Stanley Kubrick    | G      | 6-Apr-1968   |
  | The Incredibles         | Brad Bird          | PG     | 5-Nov-2004   |
  | Raiders of the Lost Ark | Steven Spielberg   | PG     | 12-Jun-1981  |
  | Chicken Run             | Nick Park          | G      | 21-Jun-2000  |

  And I am on the RottenPotatoes home page

Scenario: sort movies alphabetically by title
  When I check the following ratings: "PG, R, G, PG-13, NC-17"
  And I press "ratings_submit"
  And I follow "title_header"
  Then I should see "Aladdin" before "Amelie"

Scenario: sort movies in increasing order of release date
  When I check the following ratings: "PG, R, G, PG-13, NC-17"
  And I press "ratings_submit"
  And I follow "release_date_header"
  Then I should see "1981-06-12 00:00:00 UTC" before "2004-11-05 00:00:00 UTC"
  
Scenario: sort movies alphabetically by director
  When I check the following ratings: "PG, R, G, PG-13, NC-17"
  And I press "ratings_submit"
  And I follow "director_header"
  Then I should see "Brad Bird" before "James Cameron"
  
Scenario: create new movie
  When I check the following ratings: "PG, R, G, PG-13, NC-17"
  And I follow "add_new_movie"
  Then  I should be on the "Create New Movie" page
  And I fill in "Title" with "Frozen"
  And I fill in "Director" with "Chris Buck"
  And I select "PG" from "Rating"
  And I select "2017" from "movie_release_date_1i"
  And I select "November" from "movie_release_date_2i"
  And I select "27" from "movie_release_date_3i"
  And I press "create_movie"
  Then I should be on the RottenPotatoes home page
  And I should see "Frozen"
  
Scenario: delete movie
    When I check the following ratings: "PG, R, G, PG-13, NC-17"
    And I follow "more_about_Aladdin"
    Then I should be on the details page for "Aladdin"
    And I press "delete_movie"
    Then I should be on the RottenPotatoes home page
    And I should see "Movie 'Aladdin' deleted."
      