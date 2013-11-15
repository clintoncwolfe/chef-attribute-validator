class Chef
  class Attribute
    class Validator
      class Check
        class Present < Check

          register_check('present', Present)

          def validate_check_arg
            unless check_arg.kind_of?(TrueClass) || check_arg.kind_of?(FalseClass)
              raise "Bad 'present' check argument '#{check_arg}' for rule '#{rule_name}' - expected one of true,false"
            end
          end
    
          def check(attrset)
            violations = []
            if check_arg 
              # OK, presence is required - violate if attrset is empty
              if attrset.empty?
                violations.push Chef::Attribute::Validator::Violation.new(rule_name, path_spec, "No attributes exist for path '#{path_spec}', but this rule says its presence is required.")
              end
            else
              # Presence is taboo.  Violate on each extant attr
              attrset.each do |path, value|
                violations.push Chef::Attribute::Validator::Violation.new(rule_name, path, "This rule bans the presense of this attribute, but it exists (regardless of value).")
              end
            end
            violations
          end
        end
      end
    end
  end
end
