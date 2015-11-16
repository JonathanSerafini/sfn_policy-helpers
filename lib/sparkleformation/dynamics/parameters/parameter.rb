
# Global array containing a list of valid parameter attributes
SfnCache[:parameter_attributes] = %w(
  Type Default NoEcho
  AllowedValues AllowedPattern
  MaxLength MinLength
  MaxValue MinValue
  Description ConstraintDescription
)

# Helper method which creates optionally namespaced parameters in a similar 
# manner as how builtin dynamics function.
# 
# Exanding on the idea of namespacing parameters, it will attempt to load
# attributes from the global cache for itself and then fallback to those of
# the namespace. In this manner, we can define reusable parameter definitions
# outside of the template context.
#
# The following order of precedence will be taken into account when evaluating
# this dynamic in a context, with the overlay or first occurence taking 
# precendence :
# - overlay
# - `state!` attribute for name used as `default` value
# - `state!` attribute for namespace used as `default` value
# - `SfnParameters` for the name
# - `SfnParameters` for the namespace
#
# @param namespace [String] namespace or name of the parameter
# @param prefix [*String] optional prefixes for the name
# @param config [Hash] optional overlay
# @since 0.1.0
# 
# @example
#   SfnParameters[:autoscaling_instances_max] = {
#     type: "Number",
#     description: "Maximum amount of instances to autoscale",
#     min_value: 3,
#     default: 12
#   }
#
#   SfnParameters[:proxy_autoscaling_instances_max] = {
#     default: 3
#   }
#
#   SparkleFormation.build
#     dynamic! :parameter, :autoscaling_instances_max, :proxy, 
#       min_value: 1,
#       max_value: 12
#   end
#
#   {
#     "parameters": {
#       "proxy_autoscaling_instances_max": {
#         "type": "Number",
#         "description": "Maximum amount of instances to autoscale",
#         "default": 3,
#         "min_value": 1,
#         "max_value": 12
#       }
#     }
#   }
SparkleFormation.dynamic(:parameter) do |namespace, *args|
  config = args.pop if args.last.is_a?(Hash)
  prefix = args

  name = if prefix.any?
           [prefix.reverse, namespace].flatten.join('_').to_sym
         else namespace
         end

  state = registry!(:parameter_state, name) ||
          registry!(:parameter_state, namespace)
  state = nil if state.is_a?(Hash)

  root!.parameters.set!(name) do
    registry! :attribute_defaults, { default: state } if state
    registry! :attribute_defaults, SfnParameters.fetch(name, {})
    registry! :attribute_defaults, SfnParameters.fetch(namespace, {})
    registry! :attribute_overlays, config if config

    keys!.each do |key|
      delete!(key) unless SfnCache[:parameter_attributes].include?(key)
    end
  end
end

