require 'attribute_struct'

module SfnPolicy
  class Parameters
    class << self
      # Initialize parameters
      #
      # @return [self]
      def init!
        @parameters = AttributeStruct.hashish.new
        self
      end

      # Register block
      #
      # @param name [String, Symbol] name of item
      # @yield block to registry
      def register(name, &block)
        parameter = AttributeStruct.new
        parameter.build(&block)
        @parameters[name] = parameter
      end

      def lookup(name)
        @parameters[name]
      end

      def fetch(name, default)
        lookup(name) || default
      end
    end
  end
end

SfnParameters = SfnPolicy::Parameters.init!
