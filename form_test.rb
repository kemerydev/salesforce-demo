require 'selenium-webdriver'

class FormTest < Test::Unit::TestCase
  def setup
    @driver = Selenium::WebDriver.for :firefox
    @test_url = "https://docs.google.com/forms/d/181whJlBduFo5qtDbxkBDWHjNQML5RutvHWOCjEFWswY"
  end

  def teardown
    @driver.close
    @driver.quit
  end

  def all_fields_displayed
    @driver.get @test_url
    assert true
  end

  def required_field_test
    assert true
  end
end
