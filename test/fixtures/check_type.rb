
rules = default['attribute-validator']['rules']

default['empty'] = ''
default['foo'] = 'foo'
default['number'] = 42
default['number-as-string'] = '42'
default['98point6'] = 98.6
default['zero'] = 0
default['one'] = 1
default['nil'] = nil
default['array'] = [ 'a', 'b' ]
default['hash'] = { 'a' => 'b' }
default['false'] = false
default['true'] = true
default['false-as-string'] = 'false'
default['true-as-string'] = 'true'

default['array-as-string'] = '[1,2,3,4]'
default['array-empty'] = []
default['array-incr1'] = []
default['array-incr1'] = [ 'apples' ]
default['array-incr1'] = [ 'bananas' ]

default['array-incr2'] = [ ]
default['array-incr2'][0] = 'kodos'
default['array-incr2'][1] = 'kang'

default['array-incr3'] = [ ]
default['array-incr3'] = [ { 'lisa' => 'clobbergirl' } ]
default['array-incr3'] = [ { 'bart' => 'stretchboy' } ]

default['hash-as-string'] = '{"foo" => "bar" }'
default['hash-empty'] = {}

default['hash-incr1'] = {}
default['hash-incr1'] = { 'monday' => 'garfield hates them' }
default['hash-incr1'] = { 'wednesday' => 'favorite of the camel' }

default['hash-incr2']['zed'] = 'is dead'
default['hash-incr2']['butch'] = 'LA privileges revoked'

default['hash-incr3'] = {
  'this' => {
    'that' => "th'other"
  }
}

#===================================================#
#                String
#===================================================#
rules['string-empty'] = {
  'path' => '/empty',
  'type' => 'string',
}

rules['string-nil'] = {
  'path' => '/nil',
  'type' => 'string',
}

rules['string-foo'] = {
  'path' => '/foo',
  'type' => 'string',
}

rules['string-number'] = {
  'path' => '/number',
  'type' => 'string',
}

rules['string-array'] = {
  'path' => '/array',
  'type' => 'string',
}

rules['string-hash'] = {
  'path' => '/hash',
  'type' => 'string',
}

#===================================================#
#                Number
#===================================================#
rules['number-zero'] = {
  'path' => '/zero',
  'type' => 'number',
}

rules['number-nil'] = {
  'path' => '/nil',
  'type' => 'number',
}

rules['number-42'] = {
  'path' => '/number',
  'type' => 'number',
}

rules['number-98point6'] = {
  'path' => '/98point6',
  'type' => 'number',
}

rules['number-as-string'] = {
  'path' => '/number-as-string',
  'type' => 'number',
}

rules['number-array'] = {
  'path' => '/array',
  'type' => 'number',
}

rules['number-hash'] = {
  'path' => '/hash',
  'type' => 'number',
}

#===================================================#
#                Boolean
#===================================================#

rules['boolean-empty'] = {
  'path' => '/empty',
  'type' => 'boolean',
}

rules['boolean-zero'] = {
  'path' => '/zero',
  'type' => 'boolean',
}

rules['boolean-one'] = {
  'path' => '/one',
  'type' => 'boolean',
}

rules['boolean-nil'] = {
  'path' => '/nil',
  'type' => 'boolean',
}

rules['boolean-true'] = {
  'path' => '/true',
  'type' => 'boolean',
}

rules['boolean-false'] = {
  'path' => '/false',
  'type' => 'boolean',
}

rules['boolean-true-as-string'] = {
  'path' => '/true-as-string',
  'type' => 'boolean',
}

rules['boolean-false-as-string'] = {
  'path' => '/false-as-string',
  'type' => 'boolean',
}

rules['boolean-array'] = {
  'path' => '/array',
  'type' => 'boolean',
}

rules['boolean-hash'] = {
  'path' => '/hash',
  'type' => 'boolean',
}

#===================================================#
#                Array
#===================================================#
rules['array-empty'] = {
  'path' => '/array-empty',
  'type' => 'array',
}

rules['array-literal'] = {
  'path' => '/array',
  'type' => 'array',
}

rules['array-incremental-simple'] = {
  'path' => '/array-incr1',
  'type' => 'array',
}

rules['array-incremental-indexed'] = {
  'path' => '/array-incr2',
  'type' => 'array',
}

rules['array-incremental-deep'] = {
  'path' => '/array-incr3',
  'type' => 'array',
}

rules['array-nil'] = {
  'path' => '/nil',
  'type' => 'array',
}

rules['array-zero'] = {
  'path' => '/zero',
  'type' => 'array',
}

rules['array-as-string'] = {
  'path' => '/array-as-string',
  'type' => 'array',
}

rules['array-hash'] = {
  'path' => '/hash',
  'type' => 'array',
}

#===================================================#
#                Hash
#===================================================#
rules['hash-empty'] = {
  'path' => '/hash-empty',
  'type' => 'hash',
}

rules['hash-literal'] = {
  'path' => '/hash',
  'type' => 'hash',
}

rules['hash-incremental-simple'] = {
  'path' => '/hash-incr1',
  'type' => 'hash',
}

rules['hash-incremental-indexed'] = {
  'path' => '/hash-incr2',
  'type' => 'hash',
}

rules['hash-incremental-deep'] = {
  'path' => '/hash-incr3',
  'type' => 'hash',
}

rules['hash-nil'] = {
  'path' => '/nil',
  'type' => 'hash',
}

rules['hash-zero'] = {
  'path' => '/zero',
  'type' => 'hash',
}

rules['hash-as-string'] = {
  'path' => '/hash-as-string',
  'type' => 'hash',
}

rules['hash-array'] = {
  'path' => '/array',
  'type' => 'hash',
}
