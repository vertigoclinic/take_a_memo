ENV['IRB_MEMO_DIR'] = "/var/tmp/.irb_memos"
require File.join(File.dirname(__FILE__), '..', 'lib/take_a_memo')
include TakeAMemo

require 'stringio'
 
module Kernel
 
  def capture_stdout
    out = StringIO.new
    $stdout = out
    yield
    return out
  ensure
    $stdout = STDOUT
  end
 
end