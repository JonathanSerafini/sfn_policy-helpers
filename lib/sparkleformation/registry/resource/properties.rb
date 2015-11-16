
# Helper method used to set resource properties from a hash of configuration
# directives as well as a hash of default attributes
#
# @param overlays [Hash,Nil] overlays
# @param defaults [Hash,Nil] defaults
# @since 0.1.0
SfnRegistry.register(:properties) do |overlays = {}, defaults={}|
  overlays = {} if overlays.nil?
  defaults = {} if defaults.nil?

  resource = if self[:type] then self
             elsif self.parent![:type] then self
             else 
               message = "Registry `properties` may only be used within a"
               message << " resource where the `type` is defined"
               ::Kernel.raise ArgumentError.new message
             end

  properties = resource[:properties]

  defaults = registry!(:properties_supported, resource[:type], defaults)
  overlays = registry!(:properties_supported, resource[:type], overlays)

  properties.build! do
    if taggable?
      tag_collection = []
      tag_collection << registry!(:default_tags) rescue nil
      tag_collection << defaults.delete(:tags)
      tag_collection << self[:tags]
      tag_collection << overlays.delete(:tags)

      registry! :attribute_tags, *tag_collection
    end

    registry! :attribute_defaults, defaults
    registry! :attribute_overlays, overlays
  end
end

