class Chef
  class Attribute
    class Validator
      class Check
        class Required < Check

          register_check('required', Required)

          def validate_check_arg
            unless check_arg.kind_of?(TrueClass) || check_arg.kind_of?(FalseClass)
              raise "Bad 'required' check argument '#{check_arg}' for rule '#{rule_name}' - expected one of true,false"
            end
          end
    
          def check(attrset)
            violations = []
            if check_arg # If we are not required, we're effectively a no-op
              if attrset.empty?
                violations.push Chef::Attribute::Validator::Violation.new(rule_name, path_spec, "No attributes exist for path '#{path_spec}', but this rule says it is required.")
              else
                attrset.each do |path, value|
                  if val_scalar?(value)
                    if value.nil? 
                      violations.push Chef::Attribute::Validator::Violation.new(rule_name, path, "Attributes value is nil, but is required.")
                    elsif value == ""
                      violations.push Chef::Attribute::Validator::Violation.new(rule_name, path, "Attributes value is '', but is required.")
                    end
                  else
                    if value.size == 0
                      violations.push Chef::Attribute::Validator::Violation.new(rule_name, path, "Attribute has no children, but is required.")       
                    end
                  end
                end
              end
            end
            violations
          end
        end
      end
    end
  end
end
