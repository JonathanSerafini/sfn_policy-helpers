
# Helper method which creates optionally namespaced outputs in a similar 
# manner as how builtin dynamics function.
# 
# @param namespace [String] namespace or name of the parameter
# @param prefix [*String] optional prefixes for the name
# @param config [Hash] the output values
# @since 0.1.0
SparkleFormation.dynamic(:output) do |namespace, *args|
  config = args.pop if args.last.is_a?(Hash)
  prefix = args

  unless config.is_a?(Hash)
    ::Kernel.raise ArgumentError.new "Dynamic `output` requires configuration."
  end

  unless config[:value]
    ::Kernel.raise ArgumentError.new "Dynamic `output` requires a value."
  end

  name = if prefix.any?
           [prefix.reverse, namespace].flatten.join('_').to_sym
         else namespace
         end

  root!.outputs.set!(name) do
    config.each do |key, value|
      set!(key, value)
    end
  end
end

