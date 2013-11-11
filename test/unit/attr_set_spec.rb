require_relative './spec_helper'

describe Chef::Attribute::Validator::AttributeSet do

  let(:node) { CAVHelper.load_fixture_attributes('attr_set') }

  describe "non-wildcard, non-array slashpath access" do
    context "when the element exists" do
      it "should be able to run /one" do
        expect { Chef::Attribute::Validator::AttributeSet.new(node, '/one') }.not_to raise_error
      end
      let(:ats) { Chef::Attribute::Validator::AttributeSet.new(node, '/one') }
      it "should be able to find /one" do
        expect(ats.size).to eq 1
        expect(ats.has_key?('/one')).to be_true
        expect(ats['/one']).to eq 1
      end
    end

    context "when the element does not exist" do
      it "should be able to run /nope" do
        expect { Chef::Attribute::Validator::AttributeSet.new(node, '/nope') }.not_to raise_error
      end
      let(:ats) { Chef::Attribute::Validator::AttributeSet.new(node, '/nope') }
      it "should not be able to find /nope" do
        expect(ats.size).to eq 0
      end        
    end
  end

  describe "non-wildcard, array slashpath access" do
    context "when the element exists" do
      it "should be able to run /cats/1" do
        expect { Chef::Attribute::Validator::AttributeSet.new(node, '/cats/1') }.not_to raise_error
      end
      let(:ats) { Chef::Attribute::Validator::AttributeSet.new(node, '/cats/1') }
      it "should be able to find /cats/1" do
        expect(ats.size).to eq 1
        expect(ats.has_key?('/cats/1')).to be_true
        expect(ats['/cats/1']).to eq 'tabby'
      end
    end

    context "when the element does not exist" do
      it "should be able to run /cats/23" do
        expect { Chef::Attribute::Validator::AttributeSet.new(node, '/cats/23') }.not_to raise_error
      end
      let(:ats) { Chef::Attribute::Validator::AttributeSet.new(node, '/cats/23') }
      it "should not be able to find /cats/23" do
        expect(ats.size).to eq 0
      end        
    end
  end

end
