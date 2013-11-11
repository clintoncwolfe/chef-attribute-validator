
require 'forwardable'

class Chef
  class Attribute
    class Validator

      class AttributeSet
        attr_accessor :guts
        attr_accessor :path
        attr_accessor :node

        extend Forwardable

        def_delegators :@guts, :size, :each, :empty?, :has_key?, :[], :keys, :select, :reject

        def initialize(a_node, a_path)
          @guts = {}
          @path = a_path
          @node = a_node

          embowel
        end

        private

        def embowel
          # Split on /
          steps = path.split('/')

          # Since we begin with /, the first element is ""
          if steps[0] == "" then steps.shift end

          # Promote integer strings to integers
          steps.map! { |s| s.match(/^\d+$/) ? s.to_i : s }
          
          # TODO: some ckine of wildcard expansion
          all_steps = [ steps ]

          all_steps.each do |these_steps|
            if path_exists_by_steps?(these_steps) then
              guts['/' + these_steps.join('/')] = fetch_val_by_steps(these_steps)
            end
          end
        end

        def path_exists_by_steps? (the_steps)
          nv = node
          steps = the_steps.dup
          while steps.size > 0 
            step = steps.shift

            # binding.pry
            if nv.kind_of?(Chef::Node::ImmutableArray) then
              # TODO: what if the step isn't an int?

              if nv.size > step then
                nv = nv[step]
              else
                # Array not long enough
                return false
              end

            elsif nv.respond_to?(:has_key?) then
              if nv.has_key?(step) then
                nv = nv[step]
              else
                # No such key
                return false
              end
            else
              # Must be a scalar?
              return false
            end
          end
          return true      
        end

        def fetch_val_by_steps(the_steps)
          nv = node
          steps = the_steps.dup
          while steps.size > 0 
            nv = nv[steps.shift]
          end
          nv
        end
      end
    end
  end
end
