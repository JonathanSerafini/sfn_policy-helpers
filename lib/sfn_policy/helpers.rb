
require 'sfn_policy/helpers/version'
require 'sfn_policy/helpers/policies'
require 'sfn_policy/helpers/parameters'
require 'sparkle_formation/sparkle'

gem_root = Gem.loaded_specs['sfn_policy-helpers'].full_gem_path
srkl_root = File.join(gem_root, 'lib', 'sparkleformation')

SparkleFormation::Sparkle.register! :sfn_policy_helpers, srkl_root

