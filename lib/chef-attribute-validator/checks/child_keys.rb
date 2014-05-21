class Chef
  class Attribute
    class Validator
      class Check
        class ChildKeys < Check

          register_check('child_keys', ChildKeys)

          def validate_check_arg
            if check_arg.kind_of?(Array)
              unless check_arg.all? { |e| e.kind_of?(String) } 
                raise "Bad 'child_keys' check argument '#{check_arg}' for rule '#{rule_name}' - expected a Regexp or an Array of Strings."
              end
            elsif ! check_arg.kind_of?(Regexp)
              raise "Bad 'child_keys' check argument '#{check_arg}' for rule '#{rule_name}' - expected a Regexp or an Array of Strings."
            end
          end

          def check(attrset)
            violations = []
            attrset.each do |path, value|
              # Must be hashlike
              if [ Mash, Hash ].any? { |k| value.kind_of?(k) }
                value.keys.each do |key|
                  if check_arg.kind_of?(Array)
                    unless check_arg.include?(key)
                      violations.push Chef::Attribute::Validator::Violation.new(rule_name, path + '/' + key, "Child Key #{key} must be one of #{check_arg.join(', ')}.")                      
                    end
                  elsif check_arg.kind_of?(Regexp)
                    unless check_arg.match(key)
                      violations.push Chef::Attribute::Validator::Violation.new(rule_name, path + '/' + key, "Child Key #{key} does not match regex '#{check_arg}'")
                    end
                  end
                end
              else
                violations.push Chef::Attribute::Validator::Violation.new(rule_name, path, "Attribute's value is '#{value}', but must be a Hash-like thing to use child_keys")
              end
            end
            violations
          end

        end
      end
    end
  end
end
