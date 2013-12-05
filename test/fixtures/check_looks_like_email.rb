
default['nil'] = nil
default['empty'] = ''

default['email']['joe'] = 'joe@example.com'
default['email']['case']['lower'] = 'ray@cartalk.com'
default['email']['case']['upper'] = 'TOMMY@CARTALK.COM'

default['email']['no']['user'] = '@foo.com'
default['email']['no']['hostname'] = 'johnny@'

default['email']['bad']['quotes'] = '"Click and Clack" <show@cartalk.com>'
default['email']['bad']['spaces'] = '"Click and Clack" <show@cartalk.com>'
default['email']['bad']['phonetic'] = 'joeATfoo.com'

rules = default['attribute-validator']['rules']
rules['email-missing'] = {
  'path' =>  '/nope',
  'looks_like' => 'email',
}

rules['email-nil'] = {
  'path' =>  '/nil',
  'looks_like' => 'email',
}

rules['email-empty'] = {
  'path' =>  '/empty',
  'looks_like' => 'email',
}

rules['email-spaces'] = {
  'path' =>  '/email/bad/spaces',
  'looks_like' => 'email',
}

rules['email-case-upper'] = {
  'path' =>  '/email/case/upper',
  'looks_like' => 'email',
}

rules['email-joe'] = {
  'path' =>  '/email/joe',
  'looks_like' => 'email',
}

rules['email-no-user'] = {
  'path' =>  '/email/no/user',
  'looks_like' => 'email',
}

rules['email-no-hostname'] = {
  'path' =>  '/email/no/hostname',
  'looks_like' => 'email',
}

rules['email-quotes'] = {
  'path' =>  '/email/bad/quotes',
  'looks_like' => 'email',
}

rules['email-phonetic-at'] = {
  'path' =>  '/email/bad/phonetic',
  'looks_like' => 'email',
}



