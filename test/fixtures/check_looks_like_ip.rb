
default['nil'] = nil
default['malformed'] = '1234.123.123.123'
default['merryxmas'] = '255.255.255.255'
default['deranged'] = '300.300.300.1'
default['3not4'] = '123.123.123'
default['allones'] = '1.1.1.1'
default['slash24'] = '1.1.1.1/24'

default['v6']['empty'] = '::'

rules = default['attribute-validator']['rules']
rules['ip-nil'] = {
  'path' =>  '/nil',
  'looks_like' => 'ip',
}

rules['ip-missing'] = {
  'path' =>  '/nope',
  'looks_like' => 'ip',
}

rules['ip-malformed'] = {
  'path' =>  '/malformed',
  'looks_like' => 'ip',
}

rules['ip-merryxmas'] = {
  'path' =>  '/merryxmas',
  'looks_like' => 'ip',
}

rules['ip-deranged'] = {
  'path' =>  '/deranged',
  'looks_like' => 'ip',
}

rules['ip-3not4'] = {
  'path' =>  '/3not4',
  'looks_like' => 'ip',
}

rules['ip-allones'] = {
  'path' =>  '/allones',
  'looks_like' => 'ip',
}

rules['ip-slash24'] = {
  'path' =>  '/slash24',
  'looks_like' => 'ip',
}


rules['ip-emptyv6'] = {
  'path' =>  '/v6/empty',
  'looks_like' => 'ip',
}
