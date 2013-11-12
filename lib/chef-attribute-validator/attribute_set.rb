
require 'forwardable'

require_relative './wildcard_expander'

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

          expander = Chef::Attribute::Validator::WildcardExpander.choose(path, node)

          # TODO: less dumb thing would be to have wildcard expander just be an enumerator
          # and then call it on each access
          expander.expand_all.each do | slashpath |
            guts[slashpath] = expander.fetch_val_by_slashpath(slashpath)
          end
        end

      end
    end
  end
end
