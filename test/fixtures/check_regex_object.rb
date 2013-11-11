rules = default['attribute-validator']['rules']
rules['check-regex-object'] = {
  'path' =>  '/feh',
  'regex' => Regexp.new('foo')
}
