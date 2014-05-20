default['empty'] = ""
default['nil'] = nil

default['not']['a']['scalar']['here'] = {}


default['fruits']['a'] = 'banana'
default['fruits']['b'] = 'gichee'
default['fruits']['c'] = 'tomato'

default['cats'] = [ 'leopard', 'puma', 'mountain lion', 'catamount' ]

rules = default['attribute-validator']['rules']
rules['empty-a'] = {
  'path' =>  '/empty',
  'enum' => ['a'],
}
rules['empty-empty'] = {
  'path' =>  '/empty',
  'enum' => [],
}
rules['empty-empty-match'] = {
  'path' =>  '/empty',
  'enum' => [''],
}
rules['hash'] = {
  'path' => '/not/a/scalar',
  'enum' => [ 'a' ],
}
rules['fruits'] = {
  'path' => '/fruits/a',
  'enum' => ['banana', 'gichee', 'apple'],
}
rules['mixed-fruits'] = {
  'path' => '/fruits/b',
  'enum' => [:banana, 'gichee', 23],
}

rules['today-its-a-vegetable'] = {
  'path' => '/fruits/c',
  'enum' => ['banana', 'gichee', 'apple'],
}

rules['cougars'] = {
  'path' => '/cats/*',
  'enum' => ['leopard', 'puma', 'mountain lion', 'catamount'],
}

