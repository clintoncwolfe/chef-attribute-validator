class Chef
  class Attribute
    class Validator
      class Violation
        attr_reader :rule_name
        attr_reader :path
        attr_reader :message

        def initialize(a_rule_name, a_path, a_message)
          @rule_name = a_rule_name
          @path = a_path
          @message = a_message
        end
      end
    end
  end
end
