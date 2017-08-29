class Chef
  class Attribute
    class Validator
      class Check
        attr_accessor :path_spec
        attr_accessor :check_arg
        attr_accessor :rule_name

        def initialize(a_rule, a_check_arg)
          @path_spec = a_rule.path
          @rule_name = a_rule.name
          @check_arg = a_check_arg
        end

        def self.make(check_name, a_rule, a_check_arg)
          unless @@check_classes.has_key?(check_name)
            raise "Unrecognized option or check type '#{check_name}' for attribute validation rule '#{a_rule.name}'"
          end
          checker = @@check_classes[check_name].new(a_rule, a_check_arg)
          checker.validate_check_arg
          checker
        end

        def self.list_check_types
          @@check_classes.keys
        end

        protected

        def self.register_check (check_name, klass)
          @@check_classes ||= {}
          @@check_classes[check_name] = klass
        end

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

Dir.glob(File.join(File.dirname(__FILE__), 'checks', '*.rb')).each do |check_implementation|
  require check_implementation
end
