require_relative './spec_helper'

# Verify that the 'looks_like' check works correctly


describe "'looks_like' check" do

  describe "check registry" do
    it "should be present in the Check registry" do
      expect(Chef::Attribute::Validator::Check.list_check_types).to include('looks_like')
    end
  end

  describe "check_arg checks" do
    it "should accept 'email'" do
      node = CAVHelper.load_fixture_attributes('check_looks_like_arg_email')
      expect { Chef::Attribute::Validator.new(node) }.not_to raise_error
    end
    it "should accept 'guid'" do
      node = CAVHelper.load_fixture_attributes('check_looks_like_arg_guid')
      expect { Chef::Attribute::Validator.new(node) }.not_to raise_error
    end
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

  context "when the mode is 'guid'" do
    let(:node) { CAVHelper.load_fixture_attributes('check_looks_like_guid') }
    let(:av) { Chef::Attribute::Validator.new(node) }

    it "should not violate on missing" do
      expect(av.validate_rule('guid-missing')).to be_empty
    end

    it "should not violate on nil" do
      expect(av.validate_rule('guid-nil')).to be_empty
    end

    it "should not violate on a lower-case guid" do
      expect(av.validate_rule('guid-lower-case')).to be_empty
    end

    it "should not violate on a upper-case guid" do
      expect(av.validate_rule('guid-upper-case')).to be_empty
    end

    it "should violate on a guid without dashes" do
      expect(av.validate_rule('guid-spaces')).not_to be_empty
    end

    it "should violate on an empty string" do
      expect(av.validate_rule('guid-empty')).not_to be_empty
    end

  end

  context "when the mode is 'email'" do
    let(:node) { CAVHelper.load_fixture_attributes('check_looks_like_email') }
    let(:av) { Chef::Attribute::Validator.new(node) }

    it "should not violate on missing" do
      expect(av.validate_rule('email-missing')).to be_empty
    end

    it "should not violate on nil" do
      expect(av.validate_rule('email-nil')).to be_empty
    end

    it "should violate on an empty string" do
      expect(av.validate_rule('email-empty')).not_to be_empty
    end

    it "should not violate on joe@example.com" do
      expect(av.validate_rule('email-joe')).to be_empty
    end

    it "should not violate on a upper-case email" do
      expect(av.validate_rule('email-case-upper')).to be_empty
    end

    it "should violate on a email without a user" do
      expect(av.validate_rule('email-no-user')).not_to be_empty
    end

    it "should violate on a email without a hostname" do
      expect(av.validate_rule('email-no-hostname')).not_to be_empty
    end

    it "should violate on a email with spaces" do
      expect(av.validate_rule('email-spaces')).not_to be_empty
    end

    it "should violate on a email with quotes" do
      expect(av.validate_rule('email-quotes')).not_to be_empty
    end

    it "should violate on phonetic-at" do
      expect(av.validate_rule('email-phonetic-at')).not_to be_empty
    end

  end
end
