
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
                        'email',
                        'guid',
                        'hostname',
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
                unless value.respond_to?(:match)
                  violations.push Chef::Attribute::Validator::Violation.new(rule_name, path, "Value '#{value}' is not string-like, so it can't be a #{check_arg}")
                  next
                end
                send(('ll_check_' + check_arg).to_sym, value, path, violations)
              end
            end
            violations
          end

          private
          
          def ll_check_guid(value, path, violations)
            guid_regex = /^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$/
            unless value.match(guid_regex)
              violations.push Chef::Attribute::Validator::Violation.new(rule_name, path, "Value '#{value}' does not look like a v4 UUID (see RFC 4122)")
            end
          end

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
          
          def ll_check_email(value, path, violations)
            # This is simple and crude.  Will reject some things you might wish it didn't:
            # root@localhost
            # root
            #
            
            # Email validation with regexes is stupid.
            email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
            unless value.match(email_regex)
              violations.push Chef::Attribute::Validator::Violation.new(rule_name, path, "Value '#{value}' does not look like an email address, but I could be wrong.  If I am wrong, use a Proc instead.")
            end
          end

          def ll_check_hostname(value, path, violations)
            ip_regex = /^(\d{1,3}\.){3}\d{1,3}$/
            hostname_regex = /^([a-z0-9\-]+\.)*[a-z0-9\-]{2,}$/i

            if value.match(ip_regex)
              ll_check_ip(value, path, violations)
            else
              unless value.match(hostname_regex)
                violations.push Chef::Attribute::Validator::Violation.new(rule_name, path, "Value '#{value}' does not look like a hostname, nor an IPv4.")
              end
            end
          end
        end
      end
    end
  end
end
