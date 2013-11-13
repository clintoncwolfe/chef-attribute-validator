class Chef
  class Attribute
    class Validator
      class Check
        class Proc < Check

          register_check('proc', Proc)

          def validate_check_arg
            unless check_arg.kind_of?(::Proc)
              raise "Bad 'proc' check argument '#{check_arg}' for rule '#{rule_name}' - expected a Proc"
            end
            unless check_arg.arity == 2
              raise "Bad 'proc' check argument '#{check_arg}' for rule '#{rule_name}' - Proc must take exactly two arguments, a rule name and an AttributeSet."
            end
          end

          def check(attrset)
            check_arg.call(rule_name, attrset)
          end

        end
      end
    end
  end
end
