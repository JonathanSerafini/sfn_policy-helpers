
# Helper method used to set defaults attributes from a hash.
# 
# If the attribute is already present, then it will take precendence over 
# what is provided to this registry method.
#
# @param defaults [Hash,Nil] the attributes to set
# @since 0.1.0
#
# @example
#   SparkleFormation.build do
#     resource do
#       attribute "set from resource"
#     end
#
#     resource do
#       registry! :attribute_defaults, attribute: "set from registry",
#                                      default: "set from registry"
#     end
#   end
#
#   {
#     "resource": {
#       "attribute": "set from resource",
#       "default": "set from registry"
#     }
#   }
SfnRegistry.register(:attribute_defaults) do |defaults = {}|
  defaults.each do |key, value|
    set!(key, value) if self[key].nil? and not value.nil?
  end if defaults
end

