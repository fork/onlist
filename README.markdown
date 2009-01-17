Onlist
======

Adds white- and blacklisting capabilities to models.

Onlist also introduces 2 new hooks to your model `when_accepted` and
`when_rejected` which will be invoked just after the record gots updated by
onlist.


## SYNOPSIS

    class Mail < ActiveRecord::Base
      onlist

      def spam!
        onlist.reject
      end
    end


## SETUP

    $ script/plugin install git://github.org/fork/onlist

    # or
    $ git submodule add git://github.org/fork/onlist vendor/plugins/onlist
    $ ruby vendor/plugins/onlist/install.rb

    # and
    $ script/generate onlist


## ROADMAP

**1.0**

* allow inline listing
* onlist conditional with block
* write documentation


Source: <http://github.org/fork/onlist>


Copyright (c) 2008 Fork Unstable Media GmbH, released under the MIT license
