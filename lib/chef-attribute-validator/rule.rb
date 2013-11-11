
# TODO: dynaload checks/*

require_relative './attribute_set.rb'

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
          @enabled = true
          if a_def.has_key?('enabled')
            @enabled = a_def['enabled']
          end
          
          @checks = {}
          a_def.keys.reject { |ck| %w(path enabled).include? ck }.sort.each do |check_name|
            method_name = ('_check_' + check_name).to_sym
            if Rule.private_method_defined?(method_name)
              method(('_validate_check_arg_' + check_name).to_sym).call(a_def[check_name])
              
              # currying
              checks[check_name] = Proc.new {|attrset| method(method_name).call(a_def[check_name], attrset)}
            else
              raise "Unrecognized option or check type '#{check_name}' for attribute validation rule '#{name}'"
            end
          end
        end

        def apply(node)
          violations = []
          if enabled
            attrset = Chef::Attribute::Validator::AttributeSet.new(node, path)
            checks.each do |check_name, check_proc|
              violations += check_proc.call(attrset)
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

        private

        def val_scalar?(val)
          [
           Float,
           Integer,
           NilClass,
           TrueClass,
           FalseClass,
           String,
          ].any? { |k| val.kind_of?(k) }
        end
        
      end
    end
  end
end
