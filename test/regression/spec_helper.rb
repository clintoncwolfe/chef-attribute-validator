
require 'chef/node'

require_relative '../../lib/chef-attribute-validator'

module CAVHelper
  def load_fixture_attributes(filename, node = nil)
    node ||= Chef::Node.new
    filepath = File.join(File.dirname(__FILE__), '..', 'fixtures', filename)
    filepath = filepath.gsub(/\.rb$/, '') + '.rb'
    node.from_file(filepath)
    node
  end

  module_function :load_fixture_attributes

end
