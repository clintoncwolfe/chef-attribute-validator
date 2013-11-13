default['nil'] = nil
default['bunnies'] = [1, 2, 3, 5, 8]
default['rabbot'] = [1, 2, 3, 5, 8, 0]


rules = default['attribute-validator']['rules']

proc_never_fail = Proc.new do |rule_name, attrset|
  # No matter what, return no violations
  []
end

proc_always_fail = Proc.new do |rule_name, attrset|
  # No matter what, return a violation
  [ Chef::Attribute::Validator::Violation.new(rule_name, '/meh', 'I always fail') ]
end

proc_array_looks_fibonacci = Proc.new do |rule_name, attrset|
  violations = []
  prev1 = 0 
  prev2 = 1
  attrset.each do |path, value|
    # binding.pry
    unless value == prev1 + prev2
      violations.push Chef::Attribute::Validator::Violation.new(rule_name, path, 'Stopped looking like a fibonacci sequence')
    end
    prev1 = prev2
    prev2 = value
  end
  violations
end


rules['missing-never-fail'] = {
  'path' =>  '/nope',
  'proc' => proc_never_fail
}

rules['nil-never-fail'] = {
  'path' =>  '/nil',
  'proc' => proc_never_fail
}

rules['nil-always-fail'] = {
  'path' =>  '/nil',
  'proc' => proc_always_fail
}

rules['missing-always-fail'] = {
  'path' =>  '/nope',
  'proc' => proc_always_fail
}

rules['valid-fibo'] = {
  'path' =>  '/bunnies/*',
  'proc' => proc_array_looks_fibonacci
}
rules['invalid-fibo'] = {
  'path' =>  '/rabbot/*',
  'proc' => proc_array_looks_fibonacci
}


