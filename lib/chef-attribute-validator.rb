require "chef-attribute-validator/version"
require "chef-attribute-validator/violation"
require "chef-attribute-validator/rule"
require "chef-attribute-validator/attribute_set"

class Chef
  class Attribute
    class Validator
      
      attr_accessor :node
      attr_accessor :rules

      def initialize(a_node)
        @node = a_node
        populate_rules
      end

      def validate_all
        violations = []
        rules.each do |rulename, rule|
          violations += rule.apply(node)
        end
        violations
      end

      def validate_rule(rulename)
        unless rules.has_key?(rulename)
          raise "No such attribute validation rule named '#{rulename}' - have rules: #{rules.keys.sort.join(',')}"
        end
        rules[rulename].apply(node)
      end
      
      def validate_matching(rule_regex)
        violations = []
        rules.select { |rn,r| rule_regex.match(rn) }.each do |rulename, rule|
          violations += rule.apply(node)
        end
        violations    
      end

      private

      def populate_rules
        @rules = {}
        node['attribute-validator']['rules'].each do |rulename, ruledef|
          rules[rulename] = Chef::Attribute::Validator::Rule.new(rulename, ruledef)
        end
      end

    end
  end
end
