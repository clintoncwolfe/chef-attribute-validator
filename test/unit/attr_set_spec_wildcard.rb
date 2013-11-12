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

  describe "basic star wildcard" do

    context "when we are looking at the root element" do
      it "should be able to run '/*'" do
        expect { Chef::Attribute::Validator::AttributeSet.new(node, '/*') }.not_to raise_error
      end
      let(:ats) {  Chef::Attribute::Validator::AttributeSet.new(node, '/*') }
      it "should be able to list all root elements" do
        expect(ats.size).to eq 7
      end
    end

    context "when we use a star at the beginning of a two-step path" do
      it "should be able to run '/*/one'" do
        expect { Chef::Attribute::Validator::AttributeSet.new(node, '/*/one') }.not_to raise_error
      end
      let(:ats) {  Chef::Attribute::Validator::AttributeSet.new(node, '/*/one') }
      it "should be able to list all '/*/one'" do
        expect(ats.size).to eq 1
        expect(ats['/deeper/one']).to eq 1
      end
    end

    context "when we use a star at the end of a two-step path" do
      it "should be able to run '/deeper/*'" do
        expect { Chef::Attribute::Validator::AttributeSet.new(node, '/deeper/*') }.not_to raise_error
      end
      let(:ats) {  Chef::Attribute::Validator::AttributeSet.new(node, '/deeper/*') }
      it "should be able to list '/deeper/*'" do
        expect(ats.size).to eq 2
        expect(ats['/deeper/one']).to eq 1
        expect(ats['/deeper/deeper_yet']).to be_a_kind_of(Mash)
      end
    end

    context "when we use a star at the middle of a three-step path" do
      it "should be able to run '/deeper/*/one'" do
        expect { Chef::Attribute::Validator::AttributeSet.new(node, '/deeper/*/one') }.not_to raise_error
      end
      let(:ats) {  Chef::Attribute::Validator::AttributeSet.new(node, '/deeper/*/one') }
      it "should be able to list '/deeper/*/one" do
        expect(ats.size).to eq 1
        expect(ats['/deeper/deeper_yet/one']).to eq 1
      end
    end
      
    context "when the wildcarded step does not exist" do
      it "should be able to run '/nope/*'" do
        expect { Chef::Attribute::Validator::AttributeSet.new(node, '/nope/*') }.not_to raise_error
      end
      let(:ats) {  Chef::Attribute::Validator::AttributeSet.new(node, '/nope/*') }
      it "should not be able to find '/nope/*'" do
        expect(ats.size).to eq 0
      end

    end

  end

end
