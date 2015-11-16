
# Helper method used to extract only support properties from a hash, for a
# given resource type.
#
# @yieldparam [String] the aws resource type
# @yieldparam [Hash] the attributes hash
# @yieldreturn [Hash] the selected items
# @since 0.1.0
SfnRegistry.register(:properties_supported) do |type, configs = {}|
  configs = {} if configs.nil?

  property_list = registry!(:properties_list, type)
  selected_configs = configs.select do |key, value|
    if property_list.nil? then true
    else propery_list.include?(process_key!(key))
    end
  end

  selected_configs
end

