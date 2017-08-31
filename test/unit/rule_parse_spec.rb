require_relative './spec_helper'

# Verify that we can read rules from a node's attributes

# Given a node
# I should be able to create a Chef::Attribute::Validator
# and it should have the rules I expect

shared_examples 'constructor' do
  it 'should be able to create a Validator' do
    expect { Chef::Attribute::Validator.new(node) }.not_to raise_error
  end
end

describe 'no rules' do
  let(:node) { CAVHelper.load_fixture_attributes('rules_empty') }
  include_examples 'constructor'

  it 'should have no rules' do
    expect(Chef::Attribute::Validator.new(node).rules).to be_empty
  end
end

describe 'one rule with no checks' do
  let(:node) { CAVHelper.load_fixture_attributes('rules_no_check') }
  let(:av) { Chef::Attribute::Validator.new(node) }
  include_examples 'constructor'

  it 'should have one rule' do
    expect(av.rules.size).to eq(1)
  end

  it 'should have one rule with no checks' do
    expect(av.rules['test-no-check-rule'].check_count).to eq(0)
  end
end

describe 'one rule with a missing path' do
  let(:node) { CAVHelper.load_fixture_attributes('rules_missing_path') }

  it 'should fail during the constructor' do
    expect { Chef::Attribute::Validator.new(node) }.to raise_error("Missing 'path' attribute for attribute validation rule 'test-missing-path'")
  end
end

describe 'one rule with a type check' do
  let(:node) { CAVHelper.load_fixture_attributes('rules_type_check') }
  let(:av) { Chef::Attribute::Validator.new(node) }
  include_examples 'constructor'

  it 'should have one rule' do
    expect(av.rules.size).to eq(1)
  end

  it 'should have one rule with one check' do
    expect(av.rules['test-type-rule'].check_count).to eq(1)
  end

  it 'should have one rule with a type check check' do
    expect(av.rules['test-type-rule'].has_check?('type')).to be true
  end
end

describe 'one rule with a type check and a min_children check' do
  let(:node) { CAVHelper.load_fixture_attributes('rules_type_and_min_children') }
  let(:av) { Chef::Attribute::Validator.new(node) }
  include_examples 'constructor'

  it 'should have one rule' do
    expect(av.rules.size).to eq(1)
  end

  it 'should have one rule with two checks' do
    expect(av.rules['test-type-and-min-children-rule'].check_count).to eq(2)
  end

  it 'should have one rule with a type check check' do
    expect(av.rules['test-type-and-min-children-rule'].has_check?('type')).to be true
  end

  it 'should have one rule with a min_children check' do
    expect(av.rules['test-type-and-min-children-rule'].has_check?('min_children')).to be true
  end
end
