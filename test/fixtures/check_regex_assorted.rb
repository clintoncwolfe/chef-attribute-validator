

default['empty'] = ''
default['foo'] = 'foo'
default['bar'] = 'bar'
default['chow'] = 'food'
default['vittles'] = 'victuals'


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


