rules = default['attribute-validator']['rules']
rules['check-proc-nil'] = {
  'path' =>  '/nope',
  'proc' => Proc.new do |attrs|
    []
  end

}
