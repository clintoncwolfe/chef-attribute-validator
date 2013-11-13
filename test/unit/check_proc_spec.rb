require_relative './spec_helper'

describe "'proc' check" do

  describe "check registry" do
    it "should be present in the Check registry" do
      expect(Chef::Attribute::Validator::Check.list_check_types).to include('proc')
    end
  end

  describe "check_arg checks" do
    it "should reject nil" do
      node = CAVHelper.load_fixture_attributes('check_proc_nil')
      expect { Chef::Attribute::Validator.new(node) }.to raise_error
    end
    it "should reject a 0-arg Proc" do
      node = CAVHelper.load_fixture_attributes('check_proc_arity0')
      expect { Chef::Attribute::Validator.new(node) }.to raise_error
    end
    it "should reject a 1-arg Proc" do
      node = CAVHelper.load_fixture_attributes('check_proc_arity1')
      expect { Chef::Attribute::Validator.new(node) }.to raise_error
    end
    it "should accept a 2-arg Proc" do
      node = CAVHelper.load_fixture_attributes('check_proc_arity2')
      expect { Chef::Attribute::Validator.new(node) }.not_to raise_error
    end
    it "should reject a 3-arg Proc" do
      node = CAVHelper.load_fixture_attributes('check_proc_arity3')
      expect { Chef::Attribute::Validator.new(node) }.to raise_error
    end
  end

  describe "assorted procs" do
    let(:node) { CAVHelper.load_fixture_attributes('check_proc_assorted') }
    let(:av) { Chef::Attribute::Validator.new(node) }

    it "should not violate on a missing attribute with a never-fail proc" do
      expect(av.validate_rule('missing-never-fail')).to be_empty
    end

    it "should not violate on a nil attribute with a never-fail proc" do
      expect(av.validate_rule('nil-never-fail')).to be_empty
    end

    it "should violate on a missing attribute with an always-fail proc" do
      expect(av.validate_rule('missing-always-fail')).not_to be_empty
    end

    it "should violate on a nil attribute with an always-fail proc" do
      expect(av.validate_rule('nil-always-fail')).not_to be_empty
    end

    it "a violation should include the correct rule name" do
      expect(av.validate_rule('nil-always-fail')[0].rule_name).to eql 'nil-always-fail'
    end

    it "fibonacci scanner should not violate on a correct fib sequence" do
      expect(av.validate_rule('valid-fibo')).to be_empty
    end

    it "fibonacci scanner should violate on a incorrect fib sequence" do
      expect(av.validate_rule('invalid-fibo')).not_to be_empty
    end


  end

end
