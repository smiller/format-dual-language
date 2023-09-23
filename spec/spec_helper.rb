require 'simplecov'
SimpleCov.start do
  add_filter "/spec/"
  minimum_coverage 90
  maximum_coverage_drop 2
end
