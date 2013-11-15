

default['empty'] = ''
default['foo'] = 'foo'
default['bar'] = 'bar'
default['chow'] = 'food'
default['vittles'] = 'victuals'
default['nil'] = nil
default['false'] = false
default['one'] = 1

rules = default['attribute-validator']['rules']

rules['empty-empty'] = {
  'path' =>  '/empty',
  'regex' => /^$/,
}

rules['foo-foo'] = {
  'path' =>  '/foo',
  'regex' => /foo/,
}

rules['foo-food'] = {
  'path' =>  '/chow',
  'regex' => /foo/,
}

rules['foo-victuals'] = {
  'path' =>  '/vittles',
  'regex' => /foo/,
}

rules['not-foo-bar'] = {
  'path' =>  '/bar',
  'regex' => /^(?!foo)/,
}

rules['not-foo-foo'] = {
  'path' =>  '/foo',
  'regex' => /^(?!foo)/,
}


rules['foo-nil'] = {
  'path' =>  '/nil',
  'regex' => /foo/,
}

rules['foo-false'] = {
  'path' =>  '/false',
  'regex' => /foo/,
}

rules['foo-one'] = {
  'path' =>  '/one',
  'regex' => /foo/,
}
