require_relative './spec_helper'

# Verify that the 'looks_like' check works correctly


describe "'looks_like' check" do

  describe "check registry" do
    it "should be present in the Check registry" do
      expect(Chef::Attribute::Validator::Check.list_check_types).to include('looks_like')
    end
  end

  describe "check_arg checks" do
    it "should accept 'ip'" do
      node = CAVHelper.load_fixture_attributes('check_looks_like_arg_ip')
      expect { Chef::Attribute::Validator.new(node) }.not_to raise_error
    end
    it "should accept 'url'" do
      node = CAVHelper.load_fixture_attributes('check_looks_like_arg_url')
      expect { Chef::Attribute::Validator.new(node) }.not_to raise_error
    end
    it "should reject 'your mom'" do
      node = CAVHelper.load_fixture_attributes('check_looks_like_arg_your_mom')
      expect { Chef::Attribute::Validator.new(node) }.to raise_error
    end
    it "should reject a regex" do
      node = CAVHelper.load_fixture_attributes('check_looks_like_arg_regex')
      expect { Chef::Attribute::Validator.new(node) }.to raise_error
    end
  end

  context "when the mode is 'ip'" do
    let(:node) { CAVHelper.load_fixture_attributes('check_looks_like_ip') }
    let(:av) { Chef::Attribute::Validator.new(node) }

    it "should not violate on missing" do
      expect(av.validate_rule('ip-missing')).to be_empty
    end

    it "should not violate on nil" do
      expect(av.validate_rule('ip-nil')).to be_empty
    end

    it "should violate on 1234.123.1.1" do
      expect(av.validate_rule('ip-malformed')).not_to be_empty
    end

    it "should violate on 300.300.300.1" do
      expect(av.validate_rule('ip-deranged')).not_to be_empty
    end

    it "should violate on 123.123.123" do
      expect(av.validate_rule('ip-3not4')).not_to be_empty
    end

    it "should not violate on 1.1.1.1" do
      expect(av.validate_rule('ip-allones')).to be_empty
    end

    it "should not violate on 1.1.1.1/24" do
      expect(av.validate_rule('ip-slash24')).to be_empty
    end

    it "should not violate on 255.255.255.255" do
      expect(av.validate_rule('ip-merryxmas')).to be_empty
    end

    it "should not violate on ::" do
      expect(av.validate_rule('ip-emptyv6')).to be_empty
    end
  end

  context "when the mode is 'url'" do
    let(:node) { CAVHelper.load_fixture_attributes('check_looks_like_url') }
    let(:av) { Chef::Attribute::Validator.new(node) }

    it "should not violate on missing" do
      expect(av.validate_rule('url-missing')).to be_empty
    end

    it "should not violate on nil" do
      expect(av.validate_rule('url-nil')).to be_empty
    end

    it "should not violate on 'http://wwwwwwww.jodi.org'" do
      expect(av.validate_rule('url-http-basic')).to be_empty
    end

    it "should not violate on 'http://example.com/'" do
      expect(av.validate_rule('url-http-trailing-slash')).to be_empty
    end

    it "should not violate on 'http://example.com:8080/'" do
      expect(av.validate_rule('url-http-port')).to be_empty
    end

    it "should not violate on 'http://localhost'" do
      expect(av.validate_rule('url-http-localhost')).to be_empty
    end

  end



end
