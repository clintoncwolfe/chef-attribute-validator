class Chef
  class Attribute
    class Validator
      class WildcardExpander
        class BrutalRegex < WildcardExpander

          register(self)

          def expand_all
            # Create a massive list of all attribute paths, in slashpath format
            all_slashpaths = find_all_slashpaths

            # Convert the path_spec into a terrifying regex
            regex_spec = convert_path_spec_to_regex

            # Filter the list by grepping
            all_slashpaths.grep(regex_spec)

          end

          def suitability
            # I can do anything, but I'll do it badly
            0.1
          end

          # TODO: maybe we could cache this on the node, or something?
          def find_all_slashpaths (prefix='', node_cursor = nil)
            node_cursor ||= node
            child_paths = []

            if node_cursor.kind_of?(Array)
              node_cursor.each_index do |idx|
                child_paths.push prefix + '/' + idx.to_s
                if node_cursor[idx].kind_of?(Mash) || node_cursor[idx].kind_of?(Array)
                  child_paths += find_all_slashpaths(prefix + '/' + idx.to_s, node_cursor[idx])
                end
              end
            else
              node_cursor.keys.each do |key|
                child_paths.push prefix + '/' + key.to_s
                if node_cursor[key].kind_of?(Mash) || node_cursor[key].kind_of?(Array)
                  child_paths += find_all_slashpaths(prefix + '/' + key, node_cursor[key])
                end
              end
            end
            child_paths
          end

          def convert_path_spec_to_regex
            re = path_spec.dup

            # Anchor everything
            re = '^' + re + '$'

            # * => "anything but a slash"
            re.gsub!(/([^*])\*(?!\*)/, '\1[^\/]*')

            # ? => "any single char other than a slash"
            re.gsub!(/\?/, '[^\/]')

            # ** => "anything"
            re.gsub!(/\*\*/, '.*')

            # {,} =>  alternatives # TODO

            Regexp.new(re)

          end

        end
      end
    end
  end
end
