
# Helper method used to merge an array of hashes into a given array while
# ensuring that we do not have any duplicates for a specified hash key
#
# @param source [AttributeStruct] the context into which to merge the array
# @param id_key [Symbol] the array item's key to use as a unique identifier
# @param args [*Args] the hash items to merge in
# @since 0.1.0
#
# @example
#   SparkleFormation.build do
#     resource do
#       tags array!(
#         -> {
#           key "tag0"
#           value "tag0"
#         },
#         -> {
#           key "tag1"
#           value "tag1"
#         }
#       )
#
#       registry! :merge_unique_array tags, :key, 
#         -> {
#           key "tag2"
#           value "tag2"
#         },
#         [ { key: "tag0", value: "tag3" } ]
#     end
#   end
#
#   {
#     "resource": {
#       tags [
#         { "Key": "tag0", Value: "tag3" },
#         { "Key": "tag1", Value: "tag1" },
#         { "Key": "tag2", Value: "tag2" }
#       ]
#     }
#   }
SfnRegistry.register(:merge_unique_array) do |source, id_key, *args|
  unless(source.is_a?(Array))
    ::Kernel.raise ArgumentError.new "Expected destination to be an `Array`, got: #{source.class.to_s}"
  end

  source_items = source.map do |item|
    [item[id_key], item]
  end.compact
  source_items = _klass_new(source_items)

  merge_items = array!(*args)
  merge_items = merge_items.map do |item|
    unless item.is_a?(AttributeStruct)
      item = _klass_new._load(item)
    end
    [item[id_key], item]
  end
  merge_items = _klass_new(merge_items)

  result = source_items.data!.merge(merge_items.data!).values
  source.replace(result)
end

