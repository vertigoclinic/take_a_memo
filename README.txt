take_a_memo
===========

This is a very simple gem that allows you to capture the commands you run in your irb session in mini-scripts that you can replay later.

Installing it
==============

   $ gem install take_a_memo

Using it
===========

Here's a really basic example of how it works. 


	>> take_a_memo "remember this" do
	?>     1 + 1
	>>   end
	memo returned: 2
	=> nil

	>> show_my_memos
	Here's your memos:
	         - remember this
	=> nil

	>> play_it_back("remember this")
	memo returned: 2
	=> nil

	>> trash_this_memo("remember this")
	=> ["/Users/vertigoclinic/.irb_memos/remember_this.rb"]


You can set this up in your .irbrc file like this:

	require 'take_a_memo'
	include TakeAMemo


The storage location for the memos defaults to ~/.irb_memos, but you can change it by setting ENV['IRB_MEMO_DIR']

Contributing to take_a_memo
============================
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

Copyright
=========
Copyright (c) 2011 vertigoclinic. See LICENSE.txt for
further details.

