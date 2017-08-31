require_relative '../spec_helper'

describe Chef::Attribute::Validator::WildcardExpander::BrutalRegex do
  context 'prior to applying filter' do
    context 'when examining a shallow node' do
      let(:node) { CAVHelper.load_fixture_attributes('expander_brutal_flat') }
      let(:exp) { Chef::Attribute::Validator::WildcardExpander::BrutalRegex.new('/foo', node) }
      let(:result) { exp.find_all_slashpaths }

      it 'should prefix all entries with /' do
        expect(result.all? { |sp| sp.match(/^\//) }).to be true
      end

      it 'should find the right number of entries' do
        expect(result.size).to eql 3
      end

      it 'should find the /foo entry' do
        expect(result).to include('/foo')
      end
    end

    context 'when examining a deeper node with no arrays' do
      let(:node) { CAVHelper.load_fixture_attributes('expander_brutal_deep_hash') }
      let(:exp) { Chef::Attribute::Validator::WildcardExpander::BrutalRegex.new('/foo', node) }
      let(:result) { exp.find_all_slashpaths }

      it 'should prefix all entries with /' do
        expect(result.all? { |sp| sp.match(/^\//) }).to be true
      end

      it 'should find the right number of entries' do
        expect(result.size).to eql 7
      end

      it 'should find the /childless entry' do
        expect(result).to include('/childless')
      end
      it 'should find the /parent entry' do
        expect(result).to include('/parent')
      end
      it 'should find the /parent/child entry' do
        expect(result).to include('/parent/child')
      end
      it 'should find the /grandpappy entry' do
        expect(result).to include('/grandpappy')
      end
      it 'should find the /grandpappy/parent entry' do
        expect(result).to include('/grandpappy/parent')
      end
      it 'should find the /grandpappy/parent/child entry' do
        expect(result).to include('/grandpappy/parent/child')
      end
      it 'should find the /empty_hash entry' do
        expect(result).to include('/empty_hash')
      end
    end

    context 'when examining a deeper node with mixed arrays' do
      let(:node) { CAVHelper.load_fixture_attributes('expander_brutal_deep_mixed') }
      let(:exp) { Chef::Attribute::Validator::WildcardExpander::BrutalRegex.new('/foo', node) }
      let(:result) { exp.find_all_slashpaths }

      it 'should prefix all entries with /' do
        expect(result.all? { |sp| sp.match(/^\//) }).to be true
      end

      it 'should find the right number of entries' do
        expect(result.size).to eql 11
      end

      it 'should find the /childless entry' do
        expect(result).to include('/childless')
      end
      it 'should find the /parent entry' do
        expect(result).to include('/parent')
      end
      it 'should find the /parent/0 entry' do
        expect(result).to include('/parent/0')
      end
      it 'should find the /parent/1 entry' do
        expect(result).to include('/parent/1')
      end
      it 'should find the /empty_array entry' do
        expect(result).to include('/empty_array')
      end

      it 'should find the /aoh entry' do
        expect(result).to include('/aoh')
      end

      it 'should find the /aoh/0 entry' do
        expect(result).to include('/aoh/0')
      end

      it 'should find the /aoh/0/foo entry' do
        expect(result).to include('/aoh/0/foo')
      end
    end
  end

  context 'while converting a pathspec to a regex' do
    let(:node) { CAVHelper.load_fixture_attributes('expander_brutal_flat') }

    {
      '/foo' => '^/foo$',
      '/foo*' => '^/foo[^\/]*$',
      '/foo*/*/bar' => '^/foo[^\/]*/[^\/]*/bar$',
      '/?oo' => '^/[^\/]oo$',
      '/**'  => '^/.*$',
      '/foo/**/bar' => '^/foo/.*/bar$',
    }.each do |spec, regex|
      it "should convert '#{spec}' to '#{regex}'" do
        exp = Chef::Attribute::Validator::WildcardExpander::BrutalRegex.new(spec, node)
        expect(exp.convert_path_spec_to_regex).to eql Regexp.new(regex)
      end
    end
  end
end
