And(/^the article "([^"]*)" should have body "([^"]*)"$/) do |title, body|
  Article.find_all_by_title(title).body should eq(body)
end

Given(/^the following articles exist$/) do |table|
  # table is a Cucumber::Ast::Table
  Article.create table.hashes
end

Given(/^the following users exist:$/) do |table|
  # table is a Cucumber::Ast::Table
  User.create table.hashes
end

Given(/^the following comments exist$/) do |table|
  table.hashes.each do |comment|
    # ap comment
    # ap Article.all.to_a
    article = Article.find_by_title(comment['article'])
    user    = User.find(comment['user_id'])
    commrec = Comment.new
    commrec.article = article
    commrec.user = user
    commrec.body = comment['body']
    commrec.status_confirmed = true
    commrec.published = true
    commrec.state = :ham
    commrec.author = 'Cucumber'
    commrec.save!
    # article.comments << commrec
    # article.save
    # ap commrec.as_json
  end
end

#I fill in "merge_with" with the id of the "Article2" article
When /^(?:|I )fill in "([^"]*)" with the id of the "([^"]*)" article$/ do |field, value|
  fill_in(field, :with => Article.find_by_title(value).id)
end


Then /^I should (not )?see an element "(.*?)"$/ do |negate, selector|
  expect = negate ? :should_not : :should
  page.send(expect, have_css(selector))
end
