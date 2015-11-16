
# Helper method used to fetch a list of AWS support properties for a given
# resource type.
#
# @param [String] aws resource type
# @return [Array,Nil]
# @since 0.1.0
SfnRegistry.register(:properties_list) do |type|
  if defined?(SfnAws) and 
     definition = SfnAws.lookup(type) and
     properties = definition[:properties]
  then properties
  else nil
  end
end

