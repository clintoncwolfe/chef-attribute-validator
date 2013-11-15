class Chef
  class Attribute
    class Validator
      class Check
        class Regex < Check

          register_check('regex', Regex)

          def validate_check_arg
            unless check_arg.kind_of?(Regexp)
              raise "Bad 'regex' check argument '#{check_arg}' for rule '#{rule_name}' - expected a Regexp"
            end
          end

          def check(attrset)
            violations = []
            attrset.each do |path, value|
              if val_scalar?(value)
                if value.respond_to?(:match)
                  unless check_arg.match(value)
                    violations.push Chef::Attribute::Validator::Violation.new(rule_name, path, "Attribute's value is '#{value}', which does not match regex '#{check_arg}'")
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
