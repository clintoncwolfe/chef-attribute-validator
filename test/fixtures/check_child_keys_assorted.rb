default['nil'] = nil
default['scalar'] = 'thing'
default['array'] = [ 1, 2, 3 ]
default['empty-hash'] = {}
default['three']['foo'] = 1
default['three']['oofoo'] = 2
default['three']['foof'] = 3
default['two']['foo'] = 1
default['two']['goof'] = 1

default['foo']['foo'] = 1
default['bar']['bar'] = 1
default['barfoo']['bar'] = 1
default['barfoo']['foo'] = 1
default['foobarbaz']['foo'] = 1
default['foobarbaz']['bar'] = 1
default['foobarbaz']['baz'] = 1
default['baz']['baz'] = 1

rules = default['attribute-validator']['rules']
rules['re-foo-nil'] = {
  'path' =>  '/nil',
  'child_keys' => /foo/,
}
rules['re-foo-scalar'] = {
  'path' =>  '/scalar',
  'child_keys' => /foo/,
}
rules['re-foo-array'] = {
  'path' =>  '/array',
  'child_keys' => /foo/,
}
rules['re-foo-empty-hash'] = {
  'path' =>  '/empty-hash',
  'child_keys' => /foo/,
}
rules['re-foo-three'] = {
  'path' =>  '/three',
  'child_keys' => /foo/,
}
rules['re-foo-two'] = {
  'path' =>  '/two',
  'child_keys' => /foo/,
}

rules['ar-foo-nil'] = {
  'path' =>  '/nil',
  'child_keys' => ['foo', 'bar'],
}
rules['ar-foo-scalar'] = {
  'path' =>  '/scalar',
  'child_keys' => ['foo', 'bar'],
}
rules['ar-foo-array'] = {
  'path' =>  '/array',
  'child_keys' => ['foo', 'bar'],
}
rules['ar-foo-empty-hash'] = {
  'path' =>  '/empty-hash',
  'child_keys' => ['foo', 'bar'],
}
rules['ar-foo-foo'] = {
  'path' =>  '/foo',
  'child_keys' => ['foo', 'bar'],
}
rules['ar-foo-bar'] = {
  'path' =>  '/bar',
  'child_keys' => ['foo', 'bar'],
}
rules['ar-foo-barfoo'] = {
  'path' =>  '/barfoo',
  'child_keys' => ['foo', 'bar'],
}
rules['ar-foo-foobarbaz'] = {
  'path' =>  '/foobarbaz',
  'child_keys' => ['foo', 'bar'],
}
rules['ar-foo-baz'] = {
  'path' =>  '/baz',
  'child_keys' => ['foo', 'bar'],
}
