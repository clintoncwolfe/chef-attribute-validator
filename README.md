# Chef::Attribute::Validator

Define, enforce, and handle violations of validation rules for Chef node
attributes.  The rule definitions are themselves node attributes.  This 
gem provides the validation engine, and can be used outside of a 
convergence run; a cookbook (attribute-validator) is planned to perform
validation during a chef run, at compile or converge time.

## Usage

### Define Rules

Define rules by creating attributes that specify checks to make on node 
attributes that match a given path.  By default the library looks for rules
under node['attribute-validator']['rules'], but you can override that.

See Defining Validation Rules.

### From Within a Chef Recipe

To scan for violations of all rules, do:

     require 'chef-attribute-validator'
     violations = Chef::Attribute::Validator.new(node).validate_all

You can also apply one rule, or rules that match a regex:

     violations = Chef::Attribute::Validator.new(node).validate_rule('rulename')
     violations = Chef::Attribute::Validator.new(node).validate_matching(/matchme/)

The return value from each is an array, possibly empty.  Each array element is a simple object, with accessors:

     rule_name (string)
     path (in slash format, see REFERENCING ATTRIBUTES)
     message

A single rule may have many violations.

## Defining Validation Rules

To define validation rules, create attributes under 

     default['attribute-validator']['rules'][<rulename>]...

Each rule gets a unique name.  Each entry is hash structure with the following keys:

     path - Required.  Slash formatted path of the attributes to check.  
     enabled - Optional boolean, default true.  Set to false to knock out rule.

The remaining entries describe criteria to enforce on the value of the attribute(s) 
referenced by 'path'.  You may list zero or more.

Note that nil is permitted as a value by all checks, except the 'required' check (which performs nilness checks) and the 'proc' check (which implements arbitrary user behavior).

#### type 

Checks type of value.  One of 'string', 'number', 'boolean', 'hash', 'array'.

#### min_children

Integer.  Fails for all but Hash and Array.  For Hash and Array, minimum number of elements to be considered valid.

#### max_children 

Integer.  Fails for all but Hash and Array.  For Hash and Array, maximum number of elements to be considered valid.

#### present

Boolean.  If true, fails if the path matches zero attributes.  If false, fails if the path matches nonzero attributes.  This is most useful for enforcing deprecated attributes.  Does not consider nilness, only existence of attribute key(s).  See also required.

#### regex

Regexp.  Applies given regex to the value.  Ignored for Hash and Array.  See looks_like for a selection of canned regexen.

#### required

Boolean.  If true, fails if the path matches zero attributes, or the value is nil, or the value is the empty string, or if the value is an empty array or empty hash.  No-op if false (use present => false to enforce absence).

#### looks_like

String, one of 'email', 'guid', 'ip', 'url'.  Applies canned regexes (or more sophisticated matchers, like constructing objects from the stdlib).  Details:

##### email

Uses a naive regex to do a simple sanity check.  It may be too tight or too loose for you, in which case you can use a Proc and spend as much of your energy as you please solving that problem.

##### guid

Uses a regex to match GUID/UUIDs, like 'ec73f2a8-510d-4e6a-be5d-7b234da03c92'

##### hostname

Uses a regex to guess if it looks hostnamish.  Does not require a dot.  Accepts IPv4, and checks ranges.

##### ip

Uses the stdlib 'ipaddr' library to try to construct an IPAddr object from the value.  If it worked, it's an IP.  IPv6 is supported; ranges are checked; CIDR notation is supported; and no you can't pass a hostname to this.

##### url

Uses the stdlib 'url' library to try to construct an URI object from the value.  If it worked, it's an URL.  This is probably too loose; it will accept bare hostnames, for example.

#### enum

Array, a set of possible values.

#### proc 

A Proc, which will be evaluated to determine the validity.  The proc should take two args - a string rule name, and a Chef::Attribute::Validator::AttributeSet.  You can treat the attribute set as a hash - its each() methods will yield path, value pairs.  
The proc should return a possibly empty array of Chef::Attribute::Validator::Violations.

## Referencing Attributes

Attribute locations are described using a syntax similar to shell globs.

Given:

     /foo       - Matches node['foo']
     /foo/bar   - Matches node['foo']['bar']

## Bugs, Limitations and Roadmap

### How to Report Bugs

Open a github issue at https://github.com/clintoncwolfe/chef-attribute-validator, ideally with a failing test case, a pull request that fixes the bug, and a unicorn.

### Roadmap

#### Need examples in README

#### Some wildcard syntax not yet supported

Possibly eventually support for [<charclass>], or {<alternatives>}.

#### Planned checks:

   name_regex - Regexp.  Applies given regex to the last element in the attribute path ('basename', if you will)   

### Bugs and Defects

#### Lame Exceptions

No real exception class, just raising a bare string exception, which could certainly be improved upon; hard to catch.

#### Wildcard Expander implementation is simplistic and inefficient

BrutalRegex is terrible.

## Author

Clinton Wolfe

## Contributing

1. Fork it (https://github.com/clintoncwolfe/chef-attribute-validator)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request at (https://github.com/clintoncwolfe/chef-attribute-validator)
