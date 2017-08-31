require_relative './spec_helper'

# Verify that the 'required' check works correctly

describe "'required' check" do
  describe 'check registry' do
    it 'should be present in the Check registry' do
      expect(Chef::Attribute::Validator::Check.list_check_types).to include('required')
    end
  end

  describe 'check_arg checks' do
    it 'should accept true' do
      node = CAVHelper.load_fixture_attributes('check_required_true')
      expect { Chef::Attribute::Validator.new(node) }.not_to raise_error
    end
    it 'should accept false' do
      node = CAVHelper.load_fixture_attributes('check_required_false')
      expect { Chef::Attribute::Validator.new(node) }.not_to raise_error
    end
    it 'should reject 0' do
      node = CAVHelper.load_fixture_attributes('check_required_zero')
      expect { Chef::Attribute::Validator.new(node) }.to raise_error("Bad 'required' check argument '0' for rule 'check-required_zero' - expected one of true,false")
    end
  end

  context 'when required, but the attribute is missing' do
    let(:node) { CAVHelper.load_fixture_attributes('check_required_assorted') }
    let(:av) { Chef::Attribute::Validator.new(node) }

    it 'should violate when the attribute is missing, shallow' do
      expect(av.validate_rule('missing-shallow')).not_to be_empty
    end

    it 'should violate when the attribute is missing, deep' do
      expect(av.validate_rule('missing-deep')).not_to be_empty
    end
  end

  context 'when required, but the value is missing' do
    let(:node) { CAVHelper.load_fixture_attributes('check_required_assorted') }
    let(:av) { Chef::Attribute::Validator.new(node) }

    it 'should violate when the value is nil' do
      expect(av.validate_rule('value-nil')).not_to be_empty
    end

    it 'should violate when the value is an empty string' do
      expect(av.validate_rule('value-empty-string')).not_to be_empty
    end

    it 'should violate when the value is an empty array' do
      expect(av.validate_rule('value-empty-array')).not_to be_empty
    end

    it 'should violate when the value is an empty hash' do
      expect(av.validate_rule('value-empty-hash')).not_to be_empty
    end
  end

  context 'when required, and a value is present' do
    let(:node) { CAVHelper.load_fixture_attributes('check_required_assorted') }
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

  context 'when not required, but the value is present' do
    let(:node) { CAVHelper.load_fixture_attributes('check_required_assorted') }
    let(:av) { Chef::Attribute::Validator.new(node) }

    it 'should not violate when the value is a string' do
      expect(av.validate_rule('optional-present-string')).to be_empty
    end
  end

  context 'when not required, but the attribute is missing' do
    let(:node) { CAVHelper.load_fixture_attributes('check_required_assorted') }
    let(:av) { Chef::Attribute::Validator.new(node) }

    it 'should not violate when the attribute is missing' do
      expect(av.validate_rule('optional-missing')).to be_empty
    end
  end
end
