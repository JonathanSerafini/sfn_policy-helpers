
# Helper method used to fetch a parameter value from the state.
#
# This will rewrite the parameter name by prefixing it with param_. Should
# the value not be found, it will then lookup the modified key with an _id 
# suffix. 
#
# @param name [String] the parameter name
# @since 0.1.0
# @return [Value,Nil] the value of the state or nil
SfnRegistry.register(:parameter_state) do |name|
  if state_value = state!("param_#{name}".to_sym)
    state_value
  elsif state_value = state!("param_#{name}_id".to_sym)
    state_value
  else
    nil
  end
end

