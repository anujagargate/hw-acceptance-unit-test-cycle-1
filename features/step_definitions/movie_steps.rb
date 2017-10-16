Given /^the following movies exist:$/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    # hint: look at movies_controller#create for a hint toward the one-line solution

    Movie.create! movie
  end
end

When /^I (un)?check the following ratings: "([^"]*)"$/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb

  rating_list.strip.split(%r{\s*,\s*}).each do |rating|
    eval("#{uncheck}check(\"ratings[\"+rating+\"]\")")
    #step %Q{I #{uncheck}check “ratings[#{rating}]”}
  end
end

Then /^I should( not)? see the following movies: "([^"]*)"$/ do |notsee, movies|
  movies.strip.split(%r{\s*,\s*}).each do |movie|
	  step %Q{I should#{notsee} see “#{movie}”}
  end	
end

Then /^I should not see all the movies$/ do
  # Make sure that all the movies in the app are visible in the table
  title_elements = 
    page.all("#movies tbody td:nth-child(1)").map do |title_element|
      title_element.text
    end

  expect(title_elements).to be_empty
end

Then /^I should see all the movies$/ do
  # Make sure that all the movies in the app are visible in the table
  title_elements = 
    page.all("#movies tbody td:nth-child(1)").map do |title_element|
      title_element.text
    end

  movie_titles = Movie.pluck(:title)
 
  expect(title_elements).to match_array(movie_titles)
end

Then /^I should see "([^"]*)" before "([^"]*)"$/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  Hint: page.body is the entire content of the page as a string.
  
  text = page.body

  e1_index = text.index(e1)
  e2_index = text.index(e2)

  expect(e1_index).not_to be(nil)
  expect(e2_index).not_to be(nil)
  expect(e1_index).to be < e2_index
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |movie,director|
    step %Q{I should see "#{movie}"}
    step %Q{I should see "#{director}"}
end
