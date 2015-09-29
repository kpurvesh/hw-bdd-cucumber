# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
	Movie.create!(movie)	  	
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  ratings_arr = rating_list.split(",")
  ratings_arr.each {|rating|
			if uncheck.eql?(nil)
				step "I check \"ratings_" + rating + "\""
			elsif uncheck.eql?("un")
				step "I uncheck \"ratings_" + rating + "\""
			end
		   }		
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  value = Movie.count()
  page.all("table#movies tbody tr").count.should == value
end

Then /I should (.*) movies with following ratings: (.*)/ do |see, rating_list|
	ratings_arr = rating_list.split(",")
	ratings_arr.each {|rating|
			titles = Movie.where(rating: rating).pluck(:title)
			titles.each {|title|
				if see.eql?("see")
					step "I should see \"" + title + "\""
				elsif see.eql?("not see")
					step "I should not see \"" + title + "\""
				end
			}
	}
end


