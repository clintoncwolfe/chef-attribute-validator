
default['nil'] = nil

default['http']['basic'] = 'http://wwwwwwww.jodi.org'
default['http']['trailing-slash'] = 'http://example.com/'
default['http']['port'] = 'http://example.com:8080/'
default['http']['localhost'] = 'http://localhost'

rules = default['attribute-validator']['rules']
rules['url-missing'] = {
  'path' =>  '/nope',
  'looks_like' => 'url',
}

rules['url-nil'] = {
  'path' =>  '/nil',
  'looks_like' => 'url',
}

rules['url-http-basic'] = {
  'path' =>  '/http/basic',
  'looks_like' => 'url',
}

rules['url-http-trailing-slash'] = {
  'path' =>  '/http/trailing-slash',
  'looks_like' => 'url',
}

rules['url-http-port'] = {
  'path' =>  '/http/port',
  'looks_like' => 'url',
}
rules['url-http-localhost'] = {
  'path' =>  '/http/localhost',
  'looks_like' => 'url',
}
