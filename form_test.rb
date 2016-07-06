require 'selenium-webdriver'

class FormTest < Test::Unit::TestCase
  def setup
    @driver = Selenium::WebDriver.for :firefox
    @test_url = "https://docs.google.com/forms/d/181whJlBduFo5qtDbxkBDWHjNQML5RutvHWOCjEFWswY"
    @driver.get @test_url
  end

  def teardown
    @driver.close
    @driver.quit
  end

  def all_fields_displayed
    basic_form_xpaths.each_value { |this_xp| assert(@driver.find_element(:xpath => this_xp).displayed?, "could" \
                                                    " not find an expected form element with xpath #{this_xp}") }
  end

  def required_field_test
    @driver.find_element(:xpath => basic_form_xpaths[:submit]).click
    sleep 50
  end

  def basic_form_xpaths
    xpaths = Hash.new
    xpaths[:name_field] = "//input[contains(@aria-label,'What is your name?')]"
    xpaths[:enjoy_development_yes] = "//*[contains(@aria-label,'Do you enjoy development?')]/descendant::*[contains(.,'Yes')]/preceding-sibling::*/input[@type='checkbox']"
    xpaths[:enjoy_development_no] = "//*[contains(@aria-label,'Do you enjoy development?')]/descendant::*[contains(.,'No')]/preceding-sibling::*/input[@type='checkbox']"
    xpaths[:favorite_testing_framework] = "//select[contains(@aria-label,'What is your favorite testing framework?')]"
    xpaths[:comments] = "//textarea[contains(@aria-label,'Comments?')]"
    xpaths[:submit] = "//input[@type='submit']"
    xpaths
  end
end
