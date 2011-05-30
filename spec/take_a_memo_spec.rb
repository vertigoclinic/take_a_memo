require File.join(File.dirname(__FILE__), '..', 'spec/spec_helper')

describe "TakeAMemo" do
   
   it "should print an error if no commands are given" do
       output = capture_stdout do
           take_a_memo "remember something" 
       end
       output.string.should match("nothing to remember")
   end
    
   it "should save the commands to a file" do
    pending 
   end
   
   it "should execute the commands"  do
     pending
   end
   
   it "should allow you to replay previous commands" do
     pending
   end
   
    
end