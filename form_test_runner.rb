require 'test/unit'
require 'test/unit/ui/console/testrunner'

require_relative 'form_test'

example_tests = Test::Unit::TestSuite.new("Basic Form Tests")

example_tests << FormTest.new('all_fields_displayed')
example_tests << FormTest.new('required_field_test')

Test::Unit::UI::Console::TestRunner.run(example_tests)
