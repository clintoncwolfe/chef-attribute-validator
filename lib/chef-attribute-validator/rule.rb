require_relative './attribute_set.rb'
require_relative './check.rb'

class Chef
  class Attribute
    class Validator
      class Rule
        attr_accessor :name
        attr_accessor :path
        attr_accessor :checks
        attr_accessor :enabled
          
        def initialize (a_name, a_def)
          @name = a_name
          @path = a_def['path']

          unless path
            raise "Missing 'path' attribute for attribute validation rule '#{name}'"
          end

          @enabled = true
          if a_def.has_key?('enabled')
            @enabled = a_def['enabled']
          end
          
          @checks = {}
          a_def.keys.reject { |ck| %w(path enabled).include? ck }.sort.each do |check_name|
            checks[check_name] = Check.make(check_name, self, a_def[check_name])
          end
        end

        def apply(node)
          violations = []
          if enabled
            attrset = Chef::Attribute::Validator::AttributeSet.new(node, path)
            checks.each do |check_name, check_obj|
              violations += check_obj.check(attrset)
            end
          end
          violations
        end

        def check_count
          checks.keys.size
        end
        
        def has_check?(check_name)
          checks.has_key?(check_name)      
        end

      end
    end
  end
end
