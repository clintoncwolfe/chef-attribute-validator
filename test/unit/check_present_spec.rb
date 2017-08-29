require_relative './spec_helper'

# Verify that the 'present' check works correctly

describe "'present' check" do
  describe 'check registry' do
    it 'should be present in the Check registry' do
      expect(Chef::Attribute::Validator::Check.list_check_types).to include('present')
    end
  end

  describe 'check_arg checks' do
    it 'should accept true' do
      node = CAVHelper.load_fixture_attributes('check_present_true')
      expect { Chef::Attribute::Validator.new(node) }.not_to raise_error
    end
    it 'should accept false' do
      node = CAVHelper.load_fixture_attributes('check_present_false')
      expect { Chef::Attribute::Validator.new(node) }.not_to raise_error
    end
    it 'should reject 0' do
      node = CAVHelper.load_fixture_attributes('check_present_zero')
      expect { Chef::Attribute::Validator.new(node) }.to raise_error
    end
  end

  context 'when present is true, but the attribute is missing' do
    let(:node) { CAVHelper.load_fixture_attributes('check_present_assorted') }
    let(:av) { Chef::Attribute::Validator.new(node) }

    it 'should violate when the attribute is missing, shallow' do
      expect(av.validate_rule('missing-shallow')).not_to be_empty
    end

    it 'should violate when the attribute is missing, deep' do
      expect(av.validate_rule('missing-deep')).not_to be_empty
    end
  end

  context 'when present is true, and the value is missing' do
    let(:node) { CAVHelper.load_fixture_attributes('check_present_assorted') }
    let(:av) { Chef::Attribute::Validator.new(node) }

    it 'should not violate when the value is nil' do
      expect(av.validate_rule('value-nil')).to be_empty
    end

    it 'should not violate when the value is an empty string' do
      expect(av.validate_rule('value-empty-string')).to be_empty
    end

    it 'should not violate when the value is an empty array' do
      expect(av.validate_rule('value-empty-array')).to be_empty
    end

    it 'should not violate when the value is an empty hash' do
      expect(av.validate_rule('value-empty-hash')).to be_empty
    end
  end

  context 'when present is true, and a value is present' do
    let(:node) { CAVHelper.load_fixture_attributes('check_present_assorted') }
    let(:av) { Chef::Attribute::Validator.new(node) }

    it 'should not violate when the value is a string ' do
      expect(av.validate_rule('value-present-string')).to be_empty
    end

    it 'should not violate when the value is false ' do
      expect(av.validate_rule('value-present-false')).to be_empty
    end

    it 'should not violate when the value is zero ' do
      expect(av.validate_rule('value-present-zero')).to be_empty
    end

    it 'should not violate when the value is a non-empty array ' do
      expect(av.validate_rule('value-present-array')).to be_empty
    end

    it 'should not violate when the value is a non-empty hash' do
      expect(av.validate_rule('value-present-hash')).to be_empty
    end
  end

  context 'when present is false, but the value is present' do
    let(:node) { CAVHelper.load_fixture_attributes('check_present_assorted') }
    let(:av) { Chef::Attribute::Validator.new(node) }

    it 'should violate when the value is a string' do
      expect(av.validate_rule('spurious-present-string')).not_to be_empty
    end

    it 'should violate when the value is nil' do
      expect(av.validate_rule('spurious-present-nil')).not_to be_empty
    end
  end

  context 'when present is false, but the attribute is missing' do
    let(:node) { CAVHelper.load_fixture_attributes('check_present_assorted') }
    let(:av) { Chef::Attribute::Validator.new(node) }

    it 'should not violate when the attribute is missing' do
      expect(av.validate_rule('spurious-missing')).to be_empty
    end
  end
end
