
default['yep']['what'] = 'missed me'
default['nil'] = nil

default['empty']['string'] = ""
default['empty']['array'] = []
default['empty']['hash'] = {}

default['present']['string'] = 'foo'
default['present']['zero'] = 0
default['present']['false'] = false
default['present']['array'] = [ 'a' ] 
default['present']['hash'] = { 'a' => 'b' }



rules = default['attribute-validator']['rules']
rules['missing-shallow'] = {
  'path' =>  '/nope',
  'required' => true,
}

rules['missing-deep'] = {
  'path' =>  '/yep/nope',
  'required' => true,
}

rules['value-nil'] = {
  'path' =>  '/nil',
  'required' => true,
}

rules['value-empty-string'] = {
  'path' =>  '/empty/string',
  'required' => true,
}

rules['value-empty-array'] = {
  'path' =>  '/empty/array',
  'required' => true,
}

rules['value-empty-hash'] = {
  'path' =>  '/empty/hash',
  'required' => true,
}

rules['value-present-string'] = {
  'path' =>  '/present/string',
  'required' => true,
}

rules['value-present-false'] = {
  'path' =>  '/present/false',
  'required' => true,
}

rules['value-present-zero'] = {
  'path' =>  '/present/zero',
  'required' => true,
}

rules['value-present-array'] = {
  'path' =>  '/present/array',
  'required' => true,
}

rules['value-present-hash'] = {
  'path' =>  '/present/hash',
  'required' => true,
}

rules['optional-present-string'] = {
  'path' =>  '/present/string',
  'required' => false,
}

rules['optional-missing'] = {
  'path' =>  '/nope',
  'required' => false,
}

