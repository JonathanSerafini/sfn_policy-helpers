
# Dynamic which will load a named component into the local context.
#
# The component block will be evaluated in a standalone context with the given
# state attributes defined. Afterwards, any new state attributes as well as the
# context content will be merge back into the template.
#
# @yieldparam name [String] the name of the component to load
# @yieldparam state [Hash] (optional) the state attributes to evaluate in the new context
# 
# @yieldreturn [Self]
# @since 0.1.0
SparkleFormation.dynamic(:component) do |name, state = {}|
  block = _self.components[name.to_sym] ||=
          _self.sparkle.get(:component, name.to_sym)[:block]

  context = AttributeStruct.new
  context.set_state!(state || {})
  context.instance_exec(&block)

  context_state = context._arg_state.reject do |k,v| 
    state.nil? ? false : state.keys.include?(k.to_sym)
  end

  set_state!(context_state)
  _merge!(context)
  self
end

