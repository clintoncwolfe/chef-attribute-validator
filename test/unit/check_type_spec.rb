require_relative './spec_helper'

# Verify that the 'type' check works correctly


describe "'type' check" do

  let(:node) { CAVHelper.load_fixture_attributes('check_type') }
  let(:av) { Chef::Attribute::Validator.new(node) }

  describe "check registry" do
    it "should be present in the Check registry" do
      expect(Chef::Attribute::Validator::Check.list_check_types).to include('type')
    end
  end

  describe "string" do
    it "should not violate on an empty string" do
      expect(av.validate_rule('string-empty')).to be_empty
    end

    it "should not violate on foo" do
      expect(av.validate_rule('string-foo')).to be_empty
    end

    it "should violate on a number" do
      expect(av.validate_rule('string-number')).not_to be_empty
    end

    it "should not violate on nil" do
      expect(av.validate_rule('string-nil')).to be_empty
    end

    it "should violate on array" do
      expect(av.validate_rule('string-array')).not_to be_empty
    end

    it "should violate on hash" do
      expect(av.validate_rule('string-hash')).not_to be_empty
    end
  end

  describe "number" do
    it "should not violate on zero" do
      expect(av.validate_rule('number-zero')).to be_empty
    end

    it "should not violate on 42" do
      expect(av.validate_rule('number-42')).to be_empty
    end

    it "should not violate on 98.6" do
      expect(av.validate_rule('number-98point6')).to be_empty
    end

    it "should violate on a number as a string" do
      expect(av.validate_rule('number-as-string')).not_to be_empty
    end

    it "should not violate on nil" do
      expect(av.validate_rule('number-nil')).to be_empty
    end

    it "should violate on array" do
      expect(av.validate_rule('number-array')).not_to be_empty
    end

    it "should violate on hash" do
      expect(av.validate_rule('number-hash')).not_to be_empty
    end
  end

  describe "boolean" do
    it "should not violate on false" do
      expect(av.validate_rule('boolean-false')).to be_empty
    end

    it "should not violate on true" do
      expect(av.validate_rule('boolean-true')).to be_empty
    end

    it "should violate on a boolean true as a string" do
      expect(av.validate_rule('boolean-true-as-string')).not_to be_empty
    end

    it "should violate on a boolean false as a string" do
      expect(av.validate_rule('boolean-false-as-string')).not_to be_empty
    end

    it "should violate on zero" do
      expect(av.validate_rule('boolean-zero')).not_to be_empty
    end

    it "should violate on one" do
      expect(av.validate_rule('boolean-one')).not_to be_empty
    end

    it "should violate on empty string" do
      expect(av.validate_rule('boolean-empty')).not_to be_empty
    end

    it "should not violate on nil" do
      expect(av.validate_rule('boolean-nil')).to be_empty
    end

    it "should violate on array" do
      expect(av.validate_rule('boolean-array')).not_to be_empty
    end

    it "should violate on hash" do
      expect(av.validate_rule('boolean-hash')).not_to be_empty
    end
  end

  describe "array" do
    it "should not violate on empty array" do
      expect(av.validate_rule('array-empty')).to be_empty
    end

    it "should not violate on literal array" do
      expect(av.validate_rule('array-literal')).to be_empty
    end

    it "should not violate on incrementally built simple array" do
      expect(av.validate_rule('array-incremental-simple')).to be_empty
    end

    it "should not violate on incrementally built indexed array" do
      expect(av.validate_rule('array-incremental-indexed')).to be_empty
    end

    it "should not violate on incrementally built deep array" do
      expect(av.validate_rule('array-incremental-deep')).to be_empty
    end

    it "should violate on a array as a string" do
      expect(av.validate_rule('array-as-string')).not_to be_empty
    end

    it "should violate on zero" do
      expect(av.validate_rule('array-zero')).not_to be_empty
    end

    it "should not violate on nil" do
      expect(av.validate_rule('array-nil')).to be_empty
    end

    it "should violate on hash" do
      expect(av.validate_rule('array-hash')).not_to be_empty
    end
  end

  describe "hash" do
    it "should not violate on empty hash" do
      expect(av.validate_rule('hash-empty')).to be_empty
    end

    it "should not violate on literal hash" do
      expect(av.validate_rule('hash-literal')).to be_empty
    end

    it "should not violate on incrementally built simple hash" do
      expect(av.validate_rule('hash-incremental-simple')).to be_empty
    end

    it "should not violate on incrementally built indexed hash" do
      expect(av.validate_rule('hash-incremental-indexed')).to be_empty
    end

    it "should not violate on incrementally built deep hash" do
      expect(av.validate_rule('hash-incremental-deep')).to be_empty
    end

    it "should violate on a hash as a string" do
      expect(av.validate_rule('hash-as-string')).not_to be_empty
    end

    it "should violate on zero" do
      expect(av.validate_rule('hash-zero')).not_to be_empty
    end

    it "should not violate on nil" do
      expect(av.validate_rule('hash-nil')).to be_empty
    end

    it "should violate on array" do
      expect(av.validate_rule('hash-array')).not_to be_empty
    end
  end

end
