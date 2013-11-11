require_relative './spec_helper'

# Verify that the 'regex' check works correctly


describe "'regex' check" do

  describe "check registry" do
    it "should be present in the Check registry" do
      expect(Chef::Attribute::Validator::Check.list_check_types).to include('regex')
    end
  end

  describe "check_arg checks" do
    it "should accept a // literal regex" do
      node = CAVHelper.load_fixture_attributes('check_regex_literal')
      expect { Chef::Attribute::Validator.new(node) }.not_to raise_error
    end
    it "should accept a Regexp object" do
      node = CAVHelper.load_fixture_attributes('check_regex_object')
      expect { Chef::Attribute::Validator.new(node) }.not_to raise_error
    end
    it "should reject a string" do
      node = CAVHelper.load_fixture_attributes('check_regex_string')
      expect { Chef::Attribute::Validator.new(node) }.to raise_error
    end
    it "should reject a nil regex" do
      node = CAVHelper.load_fixture_attributes('check_regex_nil')
      expect { Chef::Attribute::Validator.new(node) }.to raise_error
    end
  end

  describe "assorted regexes" do
    let(:node) { CAVHelper.load_fixture_attributes('check_regex_assorted') }
    let(:av) { Chef::Attribute::Validator.new(node) }

    it "/^$/ should not violate on an empty string" do
      expect(av.validate_rule('empty-empty')).to be_empty
    end

    it "/foo/ should not violate on foo" do
      expect(av.validate_rule('foo-foo')).to be_empty
    end

    it "/foo/ should not violate on food" do
      expect(av.validate_rule('foo-food')).to be_empty
    end

    it "/foo/ should violate on victuals" do
      expect(av.validate_rule('foo-victuals')).not_to be_empty
    end

    it "/^(?!foo)/ should not violate on bar" do
      expect(av.validate_rule('not-foo-bar')).to be_empty
    end

    it "/^(?!foo)/ should violate on foo" do
      expect(av.validate_rule('not-foo-foo')).not_to be_empty
    end      
  end

end
