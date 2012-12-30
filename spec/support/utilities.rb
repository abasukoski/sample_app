include ApplicationHelper

def valid_signin(user)
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-error', text: message)
  end
end

RSpec::Matchers.define :have_success_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-success', text: message)
  end
end

RSpec::Matchers.define :be_accessible do |attribute|
  match do |response|
    response.class.accessible_attributes.include?(attribute)
  end
  description { "be accessible :#{attribute}" }
  failure_message_for_should { ":#{attribute} should be accessible" }
  failure_message_for_should_not { ":#{attribute} should not be accessible" }
end

def sign_in(user)
  visit signin_path
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end