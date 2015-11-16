
# Helper method used to set attributes from a hash.
#
# The hash provided will be deep merged on top of the current context, thus
# overwritting any previously defined attribute values. Content attributes such
# as strings, numbers or arrays will be replaced. 
#
# Additionally, any if any first-level hash values are nil, these will signify
# that the attribute key should be deleted. 
#
# @param overlays [Hash,Nil] the attributes to set
# @since 0.1.0
#
# @example
#   SparkleFormation.build do
#     resource do
#       attribute "set from resource"
#       deletable "set from resource"
#     end
#
#     resource do
#       registry! :attribute_overlays, attribute: "set from registry",
#                                      deletable: nil,
#                                      overlay: "set from registry"
#     end
#   end
#
#   {
#     "resource": {
#       "attribute": "set from registry",
#       "overlay": "set from registry"
#     }
#   }
SfnRegistry.register(:attribute_overlays) do |overlays = {}|
  overlays.each do |key, value|
    if value.nil?
      delete!(key)
    elsif self[key] and value.is_a?(Hash)
      registry! :merge_struct, self[key], value
    else
      set!(key, value)
    end
  end if overlays
end

