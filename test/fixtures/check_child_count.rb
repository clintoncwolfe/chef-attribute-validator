rules = default['attribute-validator']['rules']

default['nil'] = nil
default['string'] = "pants"

default['array']['empty'] = []
default['array']['one'] = [ 'mellow gold' ]
default['array']['two'] = [ 'mellow gold', 'odelay' ]
default['array']['fifty'] = ['a'] * 50

default['hash']['empty'] = {}
default['hash']['one'] = { 'a' => 1 }
default['hash']['two'] = { 'a' => 1, 'b' => 2 }

rules['min-nil'] = {
  'path' => '/nil',
  'min_children' => 1
}

rules['min-string'] = {
  'path' => '/string',
  'min_children' => 1
}

rules['min-array-empty-zero'] = {
  'path' => '/array/empty',
  'min_children' => 0
}

rules['min-array-empty-one'] = {
  'path' => '/array/empty',
  'min_children' => 1
}

rules['min-array-one-two'] = {
  'path' => '/array/one',
  'min_children' => 2
}

rules['min-hash-empty-zero'] = {
  'path' => '/hash/empty',
  'min_children' => 0
}

rules['min-hash-empty-one'] = {
  'path' => '/hash/empty',
  'min_children' => 1
}

rules['min-hash-one-two'] = {
  'path' => '/hash/one',
  'min_children' => 2
}

rules['max-nil'] = {
  'path' => '/nil',
  'max_children' => 1
}

rules['max-string'] = {
  'path' => '/string',
  'max_children' => 1
}

rules['max-array-empty-zero'] = {
  'path' => '/array/empty',
  'max_children' => 0
}

rules['max-array-zero-one'] = {
  'path' => '/array/one',
  'max_children' => 0
}

rules['max-array-one-two'] = {
  'path' => '/array/two',
  'max_children' => 1
}

rules['max-array-two-two'] = {
  'path' => '/array/two',
  'max_children' => 2
}

rules['max-hash-empty-zero'] = {
  'path' => '/hash/empty',
  'max_children' => 0
}

rules['max-hash-zero-one'] = {
  'path' => '/hash/one',
  'max_children' => 0
}

rules['max-hash-one-two'] = {
  'path' => '/hash/two',
  'max_children' => 1
}

rules['max-hash-two-two'] = {
  'path' => '/hash/two',
  'max_children' => 2
}

