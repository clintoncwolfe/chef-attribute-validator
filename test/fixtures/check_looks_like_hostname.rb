
default['nil'] = nil
default['empty'] = ''

default['hostname']['case']['lower'] = 'wombat.example.org'
default['hostname']['case']['upper'] = 'WOMBAT.EXAMPLE.ORG'
default['hostname']['spaces'] = 'wombat example.org'
default['hostname']['localhost'] = 'localhost'
default['hostname']['underscore'] = 'under_score.org'
default['hostname']['iad'] = 'foo.iad'
default['hostname']['ip']['i127'] = '127.0.0.1'
default['hostname']['ip']['i300'] = '300.300.300.300'

rules = default['attribute-validator']['rules']
rules['hostname-missing'] = {
  'path' =>  '/nope',
  'looks_like' => 'hostname',
}

rules['hostname-nil'] = {
  'path' =>  '/nil',
  'looks_like' => 'hostname',
}

rules['hostname-empty'] = {
  'path' =>  '/empty',
  'looks_like' => 'hostname',
}

rules['hostname-case-lower'] = {
  'path' =>  '/hostname/case/lower',
  'looks_like' => 'hostname',
}

rules['hostname-case-upper'] = {
  'path' =>  '/hostname/case/upper',
  'looks_like' => 'hostname',
}

rules['hostname-localhost'] = {
  'path' =>  '/hostname/localhost',
  'looks_like' => 'hostname',
}

rules['hostname-iad'] = {
  'path' =>  '/hostname/iad',
  'looks_like' => 'hostname',
}

rules['hostname-ip-127'] = {
  'path' =>  '/hostname/ip/i127',
  'looks_like' => 'hostname',
}

rules['hostname-ip-300'] = {
  'path' =>  '/hostname/ip/i300',
  'looks_like' => 'hostname',
}

rules['hostname-underscore'] = {
  'path' =>  '/hostname/underscore',
  'looks_like' => 'hostname',
}

rules['hostname-spaces'] = {
  'path' =>  '/hostname/spaces',
  'looks_like' => 'hostname',
}


