= trepan

* http://rubyforge.org/projects/trepan

== DESCRIPTION:

Trepan is a Kernel extension which augments Kernel#caller's results
with the function's arguments at each level.

== FEATURES/PROBLEMS:

== SYNOPSIS:

Regular Kernel#enhanced_caller:

  require 'trepan'

  def something(foo) enhanced_caller end
  stack = something( 42 )
  p stack.first.args # [ 42 ]

Fancy Exception#backtrace:

  require 'trepan/exception'
  def something(foo) raise end
  begin
    something( 42 )
  rescue Exception => e
    p e.backtrace.first.args # [ 42 ]
  end

== REQUIREMENTS:

Requires:

* MRI Ruby 1.8 compiled with symbols
* gdb
* bash
* make
* a working C compiler

== INSTALL:

Install this gem like any other gem:

  $ gem install trepan

== LICENSE:

(The MIT License)

Copyright (c) 2009 Josh ben Jore

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
