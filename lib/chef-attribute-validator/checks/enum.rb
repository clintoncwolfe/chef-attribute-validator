class Chef
  class Attribute
    class Validator
      class Check
        class Enum < Check

          register_check('enum', Enum)

          def validate_check_arg
            unless check_arg.kind_of?(Array)
              raise "Bad 'enum' check argument '#{check_arg}' for rule '#{rule_name}' - expected an Array"
            end
          end

          def check(attrset)
            violations = []
            attrset.each do |path, value|
              if val_scalar?(value) && ! value.nil?
                unless check_arg.include?(value)
                  violations.push Chef::Attribute::Validator::Violation.new(rule_name, path, "Attribute's value is '#{value}', which is not one of '#{check_arg.map{ |e| e.to_s }.join(',')} '")
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
