require_relative './spec_helper'

describe "'enum' check" do
  describe 'check registry' do
    it 'should be present in the Check registry' do
      expect(Chef::Attribute::Validator::Check.list_check_types).to include('enum')
    end
  end

  describe 'check_arg checks' do
    it 'should accept an empty array' do
      node = CAVHelper.load_fixture_attributes('check_enum_array_empty')
      expect { Chef::Attribute::Validator.new(node) }.not_to raise_error
    end
    it 'should accept an array of strings' do
      node = CAVHelper.load_fixture_attributes('check_enum_array_strings')
      expect { Chef::Attribute::Validator.new(node) }.not_to raise_error
    end
    it 'should accept a mixed array' do
      node = CAVHelper.load_fixture_attributes('check_enum_array_mixed')
      expect { Chef::Attribute::Validator.new(node) }.not_to raise_error
    end
    it 'should reject a string' do
      node = CAVHelper.load_fixture_attributes('check_enum_string')
      expect { Chef::Attribute::Validator.new(node) }.to raise_error("Bad 'enum' check argument 'lol, l8r, <3' for rule 'check-enum-string' - expected an Array")
    end
    it 'should reject a nil' do
      node = CAVHelper.load_fixture_attributes('check_enum_nil')
      expect { Chef::Attribute::Validator.new(node) }.to raise_error("Bad 'enum' check argument '' for rule 'check-enum-nil' - expected an Array")
    end
  end

  describe 'assorted arrays' do
    let(:node) { CAVHelper.load_fixture_attributes('check_enum_assorted') }
    let(:av) { Chef::Attribute::Validator.new(node) }

    it 'should violate on an empty string with an empty enum list' do
      expect(av.validate_rule('empty-empty')).not_to be_empty
    end

    it 'should violate on an empty string with a non-empty enum list' do
      expect(av.validate_rule('empty-a')).not_to be_empty
    end

    it "should not violate on an empty string with a '' enum list" do
      expect(av.validate_rule('empty-empty-match')).to be_empty
    end

    it 'should not violate on a nil-valued entry' do
      expect(av.validate_rule('nil')).to be_empty
    end

    it 'should not violate on a hash-valued entry' do
      expect(av.validate_rule('hash')).to be_empty
    end

    it 'should not violate on a simple entry' do
      expect(av.validate_rule('fruits')).to be_empty
    end

    it 'should not violate on a mixed entry' do
      expect(av.validate_rule('mixed-fruits')).to be_empty
    end

    it 'should not violate when running over an array attribute' do
      expect(av.validate_rule('cougars')).to be_empty
    end

    it 'should violate when a tomato is not a fruit' do
      expect(av.validate_rule('today-its-a-vegetable')).not_to be_empty
    end
  end
end
