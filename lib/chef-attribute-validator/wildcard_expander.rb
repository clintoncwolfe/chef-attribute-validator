class Chef
  class Attribute
    class Validator
      class WildcardExpander


        attr_accessor :path_spec
        attr_accessor :node

        def initialize(a_path_spec, a_node)
          @path_spec = a_path_spec
          @node = a_node
        end

        def self.choose(path_spec, node)
          # Ruby is an excellent language in which to write Perl
          @@subclasses.map {|k| k.new(path_spec, node) }.map {|e| [e, e.suitability]}.sort { b[1] <=> a[1] }.map {|e| e[0]}.first
        end

        def slashpath_to_steps(slashpath)
          steps = slashpath.split('/')

          # Since we begin with /, the first element is ""
          if steps[0] == "" then steps.shift end

          # Promote integer strings to integers
          steps.map! { |s| s.match(/^\d+$/) ? s.to_i : s }

          steps
        end


        # Note: does not handle missing values correctly!
        def fetch_val_by_slashpath(slashpath)
          nv = node
          steps = slashpath_to_steps(slashpath)
          while steps.size > 0 
            nv = nv[steps.shift]
          end
          nv
        end

        def path_exists_by_slashpath? (slashpath)
          nv = node
          steps = slashpath_to_steps(slashpath)
          while steps.size > 0 
            step = steps.shift
            
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


        def path_contains_wildcards?(path)
          [
           /\*/,
           /\*\*/,
           /\?/,
           /\[\w+\]/,
           /\{\w+(\s*,\s*\w+)?\}/, 
          ].any? { |r| r.match(path) }
        end

        protected

        def suitability
          0.0
        end

        def self.register(klass)
          @@subclasses ||= []
          @@subclasses.push klass
        end

      end
    end
  end
end

Dir.glob(File.join(File.dirname(__FILE__), 'wildcard_expander', '*.rb')).each do |expander_implementation|
  require expander_implementation
end
