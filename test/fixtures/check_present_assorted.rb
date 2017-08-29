
default['yep']['what'] = 'missed me'
default['nil'] = nil

default['empty']['string'] = ''
default['empty']['array'] = []
default['empty']['hash'] = {}

default['present']['nil'] = nil
default['present']['string'] = 'foo'
default['present']['zero'] = 0
default['present']['false'] = false
default['present']['array'] = [ 'a' ]
default['present']['hash'] = { 'a' => 'b' }

rules = default['attribute-validator']['rules']
rules['missing-shallow'] = {
  'path' =>  '/nope',
  'present' => true,
}

rules['missing-deep'] = {
  'path' =>  '/yep/nope',
  'present' => true,
}

rules['value-nil'] = {
  'path' =>  '/nil',
  'present' => true,
}

rules['value-empty-string'] = {
  'path' =>  '/empty/string',
  'present' => true,
}

rules['value-empty-array'] = {
  'path' =>  '/empty/array',
  'present' => true,
}

rules['value-empty-hash'] = {
  'path' =>  '/empty/hash',
  'present' => true,
}

rules['value-present-string'] = {
  'path' =>  '/present/string',
  'present' => true,
}

rules['value-present-false'] = {
  'path' =>  '/present/false',
  'present' => true,
}

rules['value-present-zero'] = {
  'path' =>  '/present/zero',
  'present' => true,
}

rules['value-present-array'] = {
  'path' =>  '/present/array',
  'present' => true,
}

rules['value-present-hash'] = {
  'path' =>  '/present/hash',
  'present' => true,
}

rules['spurious-present-string'] = {
  'path' =>  '/present/string',
  'present' => false,
}

rules['spurious-present-nil'] = {
  'path' =>  '/present/nil',
  'present' => false,
}

rules['spurious-missing'] = {
  'path' =>  '/nope',
  'present' => false,
}
