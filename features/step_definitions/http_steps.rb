def add_basic_auth
  if @http_basic_user && @http_basic_password
    basic_authorize @http_basic_user, @http_basic_password
  end
end

Given(/^I use an HTTP Basic username of "(.*?)" and password of "(.*?)"$/) do |user, password|
  @http_basic_user = user
  @http_basic_password = password
end

When(/^I GET "(.*?)"$/) do |url|
  add_basic_auth
  @response = get url, {}, default_headers
end

When(/^I DELETE "(.*?)"$/) do |url|
  add_basic_auth
  @response = delete url, {}, default_headers
end

Then(/^the status code is (\d+)$/) do |code|
  @response.status.to_s.should == code
end

Then(/^the Content\-Type is (.*)$/) do |content_type|
  @response.original_headers["Content-Type"].should match(content_type)
end

When(/^I POST '(.*?)' to "(.*?)"$/) do |body, url|
  add_basic_auth
  @response = post url, body, default_headers
end

When(/^I POST to "(.*?)" with:$/) do |url, table|
  params = table.hashes.reduce({}) do |merged, hash|
    merged.merge(hash[:parameter] => hash[:value])
  end

  add_basic_auth
  @response = post url, params, default_headers
end

When(/^I PUT to "(.*?)" with:$/) do |url, table|
  params = table.hashes.reduce({}) do |merged, hash|
    merged.merge(hash[:parameter] => hash[:value])
  end

  add_basic_auth
  @response = put url, params, default_headers
end
