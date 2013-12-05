
default['nil'] = nil
default['empty'] = ''

default['guid']['case']['lower'] = 'ec73f2a8-510d-4e6a-be5d-7b234da03c92'
default['guid']['case']['upper'] = 'ACCF642E-2CD3-4D20-921E-A80E91EAFEC8'
default['guid']['spaces'] = 'db592238 8175 491b a914 f1e4eaf732bf'

rules = default['attribute-validator']['rules']
rules['guid-missing'] = {
  'path' =>  '/nope',
  'looks_like' => 'guid',
}

rules['guid-nil'] = {
  'path' =>  '/nil',
  'looks_like' => 'guid',
}

rules['guid-empty'] = {
  'path' =>  '/empty',
  'looks_like' => 'guid',
}

rules['guid-spaces'] = {
  'path' =>  '/guid/spaces',
  'looks_like' => 'guid',
}

rules['guid-upper-case'] = {
  'path' =>  '/guid/case/upper',
  'looks_like' => 'guid',
}

rules['guid-lower-case'] = {
  'path' =>  '/guid/case/lower',
  'looks_like' => 'guid',
}
