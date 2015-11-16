
# Helper method used to fetch a list of AWS support properties for a given
# resource type.
#
# @yieldparam type [String] the aws resource type
# @yieldreturn [Array,Nil]
# @since 0.1.0
SfnRegistry.register(:properties_list) do |type|
  if defined?(SfnAws) and 
     definition = SfnAws.lookup(type) and
     properties = definition[:properties]
  then properties
  else nil
  end
end

