require_relative './spec_helper'

# Verify that the 'child_keys' check works correctly

describe "'child_keys' check" do

  describe 'check registry' do
    it 'should be present in the Check registry' do
      expect(Chef::Attribute::Validator::Check.list_check_types).to include('child_keys')
    end
  end

  describe 'check_arg checks' do
    it 'should accept a // literal regex' do
      node = CAVHelper.load_fixture_attributes('check_child_keys_arg_literal_regex')
      expect { Chef::Attribute::Validator.new(node) }.not_to raise_error
    end
    it 'should accept a Regexp object' do
      node = CAVHelper.load_fixture_attributes('check_child_keys_arg_regexp_object')
      expect { Chef::Attribute::Validator.new(node) }.not_to raise_error
    end
    it 'should accept an Array of Strings' do
      node = CAVHelper.load_fixture_attributes('check_child_keys_arg_array')
      expect { Chef::Attribute::Validator.new(node) }.not_to raise_error
    end
    it 'should reject a string' do
      node = CAVHelper.load_fixture_attributes('check_child_keys_arg_string')
      expect { Chef::Attribute::Validator.new(node) }.to raise_error
    end
    it 'should reject a nil regex' do
      node = CAVHelper.load_fixture_attributes('check_child_keys_arg_nil')
      expect { Chef::Attribute::Validator.new(node) }.to raise_error
    end
  end

  describe 'assorted regexes' do
    let(:node) { CAVHelper.load_fixture_attributes('check_child_keys_assorted') }
    let(:av) { Chef::Attribute::Validator.new(node) }

    # Must be a hash to have keys - empty hash OK
    it '/foo/ should violate on nil' do
      expect(av.validate_rule('re-foo-nil')).not_to be_empty
    end

    it '/foo/ should violate on a scalar' do
      expect(av.validate_rule('re-foo-scalar')).not_to be_empty
    end

    it '/foo/ should violate on an array' do
      expect(av.validate_rule('re-foo-array')).not_to be_empty
    end

    it '/foo/ should not violate on empty hash' do
      expect(av.validate_rule('re-foo-empty-hash')).to be_empty
    end

    it '/foo/ should not violate on foo, oofoo, foof' do
      expect(av.validate_rule('re-foo-three')).to be_empty
    end

    it '/foo/ should violate on foo, goof' do
      expect(av.validate_rule('re-foo-two')).not_to be_empty
    end
  end

  describe 'assorted arrays' do
    let(:node) { CAVHelper.load_fixture_attributes('check_child_keys_assorted') }
    let(:av) { Chef::Attribute::Validator.new(node) }

    # Must be a hash to have keys - empty hash OK
    it "['foo', 'bar'] should violate on nil" do
      expect(av.validate_rule('ar-foo-nil')).not_to be_empty
    end

    it "['foo', 'bar'] should violate on a scalar" do
      expect(av.validate_rule('ar-foo-scalar')).not_to be_empty
    end

    it "['foo', 'bar'] should violate on an array" do
      expect(av.validate_rule('ar-foo-array')).not_to be_empty
    end

    it "['foo', 'bar'] should not violate on empty hash" do
      expect(av.validate_rule('ar-foo-empty-hash')).to be_empty
    end

    it "['foo', 'bar'] should not violate on foo" do
      expect(av.validate_rule('ar-foo-foo')).to be_empty
    end

    it "['foo', 'bar'] should not violate on bar" do
      expect(av.validate_rule('ar-foo-bar')).to be_empty
    end

    it "['foo', 'bar'] should not violate on bar, foo" do
      expect(av.validate_rule('ar-foo-barfoo')).to be_empty
    end

    it "['foo', 'bar'] should violate on foo, bar, baz" do
      expect(av.validate_rule('ar-foo-foobarbaz')).not_to be_empty
    end

    it "['foo', 'bar'] should violate on baz" do
      expect(av.validate_rule('ar-foo-baz')).not_to be_empty
    end

  end

end
