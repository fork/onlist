Onlist
======

Adds whitelisting, blacklisting and scheduling capabilities to models. Onlist
also introduces 2 new hooks to your model (`when_accepted`, `when_rejected`).
These are invoked just after the record is updated by Onlist.


## SYNOPSIS
### I want to notify the user about his/her login:
    class Login < ActiveRecord::Base
      onlist
      when_accepted :deliver_good_news
      when_rejected :deliver_bad_news
    end
    
    assert Login.create.unlisted?
    assert_equal 1, Login.unlisted.count # :unlisted is a named scope

    assert Login.create.accept.accepted? # :accept returns self
    assert Login.create.reject.rejected? # :reject, too

### I've got a special that should be available the next 3 hours:

    Special = Class.new(ActiveRecord::Base) { onlist }

    # :reject with Time object
    scheduled_special = Special.create.accept.reject_at Time.now + 3.hours
    assert scheduled_special.accepted?
    sleep 3.hours
    assert scheduled_special.rejected?

### I've got an Article that should be published in 3 hours:
    class Article < ActiveRecord::Base
      # aggregate onlist proxy
      on_whitelist :composed_of => :published_at
    end
    # in whitelist mode all Articles are rejected by default
    assert_equal Article.create.unlisted?, Article.create.rejected?

    # :accept with Time object
    scheduled_article = Article.create.accept_at Time.now + 3.hours
    assert_equal 3, Article.rejected.count
    sleep 3.hours
    assert_equal 1, Article.accepted.count

## SETUP

    $ script/plugin install git://github.org/fork/onlist

    # or
    $ git submodule add git://github.org/fork/onlist vendor/plugins/onlist
    $ ruby vendor/plugins/onlist/install.rb

    # and
    $ script/generate onlist


## ROADMAP

**1.0**

* stable API
* either aggregated or associated onlist
* documentation


Source: <http://github.org/fork/onlist>


Copyright (c) 2008 Fork Unstable Media GmbH, released under the MIT license
