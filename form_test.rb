require 'selenium-webdriver'
require 'yaml'

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
    if @driver.find_elements(:xpath => required_items_xpath).size > 0
      @driver.find_element(:xpath => basic_form_xpaths[:submit]).click
      
      # the assertion below passes because it checks for the presence of at least one warning message without an assertion on the visibility
      msg = "could  not find an expected missing required field message with the xpath #{required_message_xpath}"
      assert(@driver.find_elements(:xpath => required_message_xpath).size > 0, msg)
    end
  end

  def required_items_xpath
    "//div[contains(@class,'item-required')]"
  end

  def required_message_xpath 
    "//div[contains(@class,'required-message')]"
  end

  def basic_form_xpaths
    xpaths = YAML.load_file('form_locators.yml')
    xpaths["basic_form"]
  end
end
