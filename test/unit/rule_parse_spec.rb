require_relative './spec_helper'

# Verify that we can read rules from a node's attributes

# Given a node
# I should be able to create a Chef::Attribute::Validator
# and it should have the rules I expect

shared_examples "constructor" do
  it "should be able to create a Validator" do
    expect { Chef::Attribute::Validator.new(node) }.not_to raise_error
  end
end

describe "no rules" do
  let(:node) { CAVHelper.load_fixture_attributes('rules_empty') }
  include_examples "constructor"

  it "should have no rules" do
    expect(Chef::Attribute::Validator.new(node).rules).to be_empty
  end
end

describe "one rule with no checks" do
  let(:node) { CAVHelper.load_fixture_attributes('rules_no_check') }
  let(:av) { Chef::Attribute::Validator.new(node) }
  include_examples "constructor"

  it "should have one rule" do
    expect(av.rules.size).to eq(1)
  end

  it "should have one rule with no checks" do
    expect(av.rules['test-no-check-rule'].check_count).to eq(0)
  end

end




