require 'attribute_struct'

module SfnPolicy
  class Policies
    class << self
      # Initialize policies
      #
      # @return [self]
      def init!
        @policies = AttributeStruct.hashish.new
        @resource_types = AttributeStruct.hashish.new
        self
      end

      # Register block
      #
      # @param type [String, Symbol] resource_type policy applies to
      # @param policy_name [String] name of the policy
      # @yield block to registry
      def register(type, policy_name, &block)
        @policies[policy_name] = block
        @resource_types[type] ||= []
        @resource_types[type].push(policy_name).uniq!
      end

      # Find policies applying to resource_type
      #
      # @param type [String, Symbol] resource_type to lookup
      # @return [Array] the policy blocks
      def lookup(type)
        @resource_types[type] || []
      end
    end
  end
end

SfnPolicies = SfnPolicy::Policies.init!
