
# Helper method to set unique resource tags.
#
# This method will override the current tags with those provided to the
# registry while also ensuring that only a single tag is set for each Key.
#
# @param args [Array] the tags to set in order of importance
# @since 0.1.0
#
# @example
#   SparkleFormatiom.build do
#     resource do
#       properties do
#         tags array!(
#           -> { 
#             key "tag0"
#             value "tag0"
#           },
#           -> {
#             key "tag1"
#             value "overriden"
#           }
#         )
#         registry! :attribute_tags, tags, 
#           { key: tag1, value: tag1 },
#           -> {
#             key "tag2"
#             value "tag2"
#           }
#       end
#     end
#   end
#
#   {
#     "resource": {
#       "properties": {
#         "tags": [
#           { "Key": "tag0", "Value": "tag0" },
#           { "Key": "tag1", "Value": "tag1" },
#           { "Key": "tag2", "Value": "tag2" }
#         ]
#       }
#     }
#   }
SfnRegistry.register(:attribute_tags) do |*args|
  unless taggable?
    ::Kernel.raise ArgumentError.
      new "Registry `attribute_tags` may only be run on a taggable resource"
  end

  data = []
  registry! :merge_unique_array, data, :key, *args.compact.flatten

  tags data
end

