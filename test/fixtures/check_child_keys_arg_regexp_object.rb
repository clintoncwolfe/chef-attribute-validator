rules = default['attribute-validator']['rules']
rules['check-child-keys-arg-regexp-object'] = {
  'path' =>  '/nil',
  'child_keys' => Regexp.new('foo')
}
