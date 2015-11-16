
# Helper method used to deep merge a hash into the given context
#
# @param destination [AttributeStruct] the context into which to merge the hash
# @param data [Hash] the hash to merge
# @since 0.1.0
SfnRegistry.register(:merge_struct) do |destination, data = {}|
  data = {} if data.nil?

  unless(destination.is_a?(AttributeStruct))
    ::Kernel.raise ArgumentError.new "Expected `AttributeStruct` type."
  end

  attributes = _klass_new
  attributes._camel_keys = destination._camel_keys
  attributes._load(data)
  destination._merge!(attributes)
end

