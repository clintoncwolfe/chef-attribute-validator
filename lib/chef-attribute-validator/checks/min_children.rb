class Chef
  class Attribute
    class Validator
      class Check
        class MinChildren < Check

          register_check('min_children', MinChildren)

          def validate_check_arg
            unless check_arg.kind_of?(::Fixnum)
              raise "Bad 'min_children' check argument '#{check_arg}' for rule '#{rule_name}' - expected an integer."
            end
          end

          def check(attrset)
            violations = []

            # So if you say there must be at least one child, and the attributes don't even exist, is that a violation?
            # I say no; if you can if the attributes exist, use required.
            attrset.each do |path, value|
              if value.kind_of?(Array) || value.kind_of?(Mash)
                if value.size < check_arg
                  violations.push Chef::Attribute::Validator::Violation.new(rule_name, path, "Attribute should have at least #{check_arg} child values, but has only #{value.size}")
                end
              else
                violations.push Chef::Attribute::Validator::Violation.new(rule_name, path, "Attribute should have at least #{check_arg} child values, but is of the wrong type - should be hash or array.")
              end
            end
            violations

          end

        end
      end
    end
  end
end
