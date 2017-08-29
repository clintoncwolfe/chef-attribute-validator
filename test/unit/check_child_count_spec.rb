require_relative './spec_helper'

# Verify that the 'type' check works correctly

describe "'min_children' check" do
  let(:node) { CAVHelper.load_fixture_attributes('check_child_count') }
  let(:av) { Chef::Attribute::Validator.new(node) }

  it 'should be present in the Check registry' do
    expect(Chef::Attribute::Validator::Check.list_check_types).to include('min_children')
  end

  it 'should violate on nil' do
    expect(av.validate_rule('min-nil')).not_to be_empty
  end

  it 'should violate on string' do
    expect(av.validate_rule('min-string')).not_to be_empty
  end

  context 'when examining an array' do
    it 'should not violate when min is 0 and array is empty' do
      expect(av.validate_rule('min-array-empty-zero')).to be_empty
    end

    it 'should violate when min is 1 and array is empty' do
      expect(av.validate_rule('min-array-empty-one')).not_to be_empty
    end

    it 'should violate when min is 2 and array is 1' do
      expect(av.validate_rule('min-array-one-two')).not_to be_empty
    end
  end

  context 'when examining a hash' do
    it 'should not violate when min is 0 and hash is empty' do
      expect(av.validate_rule('min-hash-empty-zero')).to be_empty
    end

    it 'should violate when min is 1 and hash is empty' do
      expect(av.validate_rule('min-hash-empty-one')).not_to be_empty
    end

    it 'should violate when min is 2 and hash is 1' do
      expect(av.validate_rule('min-hash-one-two')).not_to be_empty
    end
  end
end

describe "'max_children' check" do
  let(:node) { CAVHelper.load_fixture_attributes('check_child_count') }
  let(:av) { Chef::Attribute::Validator.new(node) }

  it 'should be present in the Check registry' do
    expect(Chef::Attribute::Validator::Check.list_check_types).to include('max_children')
  end

  it 'should violate on nil' do
    expect(av.validate_rule('max-nil')).not_to be_empty
  end

  it 'should violate on string' do
    expect(av.validate_rule('max-string')).not_to be_empty
  end

  context 'when examining an array' do
    it 'should not violate when max is 0 and array is empty' do
      expect(av.validate_rule('max-array-empty-zero')).to be_empty
    end

    it 'should violate when max is 0 and array is 1' do
      expect(av.validate_rule('max-array-zero-one')).not_to be_empty
    end

    it 'should violate when max is 1 and array is 2' do
      expect(av.validate_rule('max-array-one-two')).not_to be_empty
    end

    it 'should not violate when max is 2 and array is 2' do
      expect(av.validate_rule('max-array-two-two')).to be_empty
    end
  end

  context 'when examining a hash' do
    it 'should not violate when max is 0 and hash is empty' do
      expect(av.validate_rule('max-hash-empty-zero')).to be_empty
    end

    it 'should violate when max is 0 and hash is one' do
      expect(av.validate_rule('max-hash-zero-one')).not_to be_empty
    end

    it 'should violate when max is 1 and hash is 2' do
      expect(av.validate_rule('max-hash-one-two')).not_to be_empty
    end

    it 'should not violate when max is 2 and hash is 2' do
      expect(av.validate_rule('max-hash-two-two')).to be_empty
    end
  end
end
