
require 'ipaddr'
require 'uri'

class Chef
  class Attribute
    class Validator
      class Check
        class LooksLike < Check

          register_check('looks_like', LooksLike)

          def validate_check_arg
            expected = [
                        'ip',
                        'url',
                       ]
       
            unless expected.include?(check_arg)
              raise "Bad 'looks_like' check argument '#{check_arg}' for rule '#{rule_name}' - expected one of #{expected.join(',')}"
            end
          end
          
          def check(attrset)
            violations = []
            attrset.each do |path, value|
              if val_scalar?(value) then
                next if value.nil?
                send(('ll_check_' + check_arg).to_sym, value, path, violations)
              end
            end
            violations
          end

          private
          
          def ll_check_ip(value, path, violations)
            begin
              IPAddr.new(value)
            rescue
              violations.push Chef::Attribute::Validator::Violation.new(rule_name, path, "Value '#{value}' does not look like an IP address")
            end  
          end

          def ll_check_url(value, path, violations)
            begin
              URI(value)
            rescue
              violations.push Chef::Attribute::Validator::Violation.new(rule_name, path, "Value '#{value}' does not look like a URL")
            end
          end
          
        end
      end
    end
  end
end
