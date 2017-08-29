require_relative './spec_helper.rb'

describe 'Issue #4 - When the search path contains a stringified integer' do
  let(:node) { CAVHelper.load_fixture_attributes('regression_4_integer_in_path') }
  
  context 'when there is no wildcard in the path' do

    context 'when the path spec contains a single-digit int' do
      context 'when the targetted attribute is an array' do        
        let(:exp) { Chef::Attribute::Validator::WildcardExpander.choose('/array/0/child0', node) }
        it 'should find the entry' do
          expect(exp.expand_all).to include('/array/0/child0')
        end
      end
      context 'when the targetted attribute is a hash' do        
        let(:exp) { Chef::Attribute::Validator::WildcardExpander.choose('/hash/0/child0', node) }
        it 'should find the entry' do
          expect(exp.expand_all).to include('/hash/0/child0')
        end
      end      
    end

    context 'when the path spec contains a two-digit int' do
      context 'when the targetted attribute is an array' do        
        let(:exp) { Chef::Attribute::Validator::WildcardExpander.choose('/array/00/child0', node) }
        it 'should NOT find the entry' do
          expect(exp.expand_all).not_to include('/array/00/child0')
        end
      end
      context 'when the targetted attribute is a hash' do        
        let(:exp) { Chef::Attribute::Validator::WildcardExpander.choose('/hash/00/child00', node) }
        it 'should find the entry' do
          expect(exp.expand_all).to include('/hash/00/child00')
        end
      end      
    end

  end

  context 'when there is a wildcard on the int segment' do

    context 'when the path spec contains a single-digit int' do
      context 'when the targetted attribute is an array' do        
        let(:exp) { Chef::Attribute::Validator::WildcardExpander.choose('/array/*/child0', node) }
        it 'should find the entry' do
          expect(exp.expand_all).to include('/array/0/child0')
        end
      end
      context 'when the targetted attribute is a hash' do        
        let(:exp) { Chef::Attribute::Validator::WildcardExpander.choose('/hash/*/child0', node) }
        it 'should find the entry' do
          expect(exp.expand_all).to include('/hash/0/child0')
        end
      end      
    end

    context 'when the path spec contains a two-digit int' do
      context 'when the targetted attribute is an array' do        
        let(:exp) { Chef::Attribute::Validator::WildcardExpander.choose('/array/*/child0', node) }
        it 'should NOT find the entry' do
          expect(exp.expand_all).not_to include('/array/00/child0')
        end
      end
      context 'when the targetted attribute is a hash' do        
        let(:exp) { Chef::Attribute::Validator::WildcardExpander.choose('/hash/*/child00', node) }
        it 'should find the entry' do
          expect(exp.expand_all).to include('/hash/00/child00')
        end
      end      
    end

  end

  context 'when there is a wildcard prior to the int segment' do

    context 'when the path spec contains a single-digit int' do
      context 'the targetted attribute is an array' do        
        let(:exp) { Chef::Attribute::Validator::WildcardExpander.choose('/deeper_array/*/0/child0', node) }
        it 'should find the entry' do
          expect(exp.expand_all).to include('/deeper_array/poney/0/child0')
        end
      end
      context 'when the targetted attribute is a hash' do        
        let(:exp) { Chef::Attribute::Validator::WildcardExpander.choose('/deeper_hash/*/0/child0', node) }
        it 'should find the entry' do
          expect(exp.expand_all).to include('/deeper_hash/poney/0/child0')
        end
      end      
    end

    context 'when the path spec contains a two-digit int' do
      context 'the targetted attribute is an array' do        
        let(:exp) { Chef::Attribute::Validator::WildcardExpander.choose('/deeper_array/*/00/child0', node) }
        it 'should NOT find the entry' do
          expect(exp.expand_all).not_to include('/deeper_array/poney/00/child0')
        end
      end
      context 'when the targetted attribute is a hash' do        
        let(:exp) { Chef::Attribute::Validator::WildcardExpander.choose('/deeper_hash/*/00/child00', node) }
        it 'should find the entry' do
          expect(exp.expand_all).to include('/deeper_hash/poney/00/child00')
        end
      end      
    end

  end
end
