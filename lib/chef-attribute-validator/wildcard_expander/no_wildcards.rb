class Chef
  class Attribute
    class Validator
      class WildcardExpander
        class NoWildcards < WildcardExpander

          register(self)

          def expand_all
            if path_exists_by_slashpath?(path_spec)
              [ path_spec ]
            else
              [ ]
            end
          end

          def suitability
            if path_contains_wildcards?(path_spec)
              0.0
            else
              1.0
            end
          end

        end
      end
    end
  end
end
