require File.join(File.dirname(__FILE__), '..', 'spec/spec_helper')
require 'fileutils'

describe "TakeAMemo" do

  before do 
    
  end

  it "should print an error if no commands are given" do
    output = capture_stdout do
      take_a_memo "remember something"
    end
    output.string.should match("nothing to remember")
  end

  it "should create a file for the commands" do
    take_a_memo "remember something" do
      1 + 1
      puts "#{1 + 1}"
    end
    File.exists?("#{ENV['IRB_MEMO_DIR']}/remember_something.rb").should_not be(false)
  end

  it "should put the commands in the file" do
    take_a_memo "remember_something" do
      1 + 1
      puts "#{1 + 1}"
    end
    File.open("#{ENV['IRB_MEMO_DIR']}/remember_something.rb").read.should match("puts")
  end

  it "should execute a single command" do
    output = capture_stdout do
      take_a_memo "remember_something" do
        puts "hello"
      end
    end
    output.string.should match("hello")
  end

  it "should execute multiple commands" do
    output = capture_stdout do
      take_a_memo "remember_something" do
        h = Hash.new(:a => 1, :b => 4)
        1 + 1
      end
    end
    output.string.should match("2")
  end

  it "should allow you to replay previous commands" do
    take_a_memo "remember_something" do
      h = Hash.new(:a => 1, :b => 4)
      1 + 1
    end
    output = capture_stdout do
      play_it_back("remember_something")
    end
    output.string.should match("2")
  end

  it "should display a list of your commands" do
    %w[one two three].each do |num|
      take_a_memo "remember #{num}" do
        1 + 1
      end
    end
    output = capture_stdout do
      show_my_memos
    end
    output.string.should match("three")
  end
  
  it "should show a message if there are no commands to list" do
      output = capture_stdout do 
          show_my_memos
      end
      output.string.should match("you have no saved memos")
  end

  it "should allow you to remove unwanted commands" do
    %w[one two three].each do |num|
      take_a_memo "remember #{num}" do
        1 + 1
      end
    end
    trash_this_memo("remember three")
    output = capture_stdout do
      show_my_memos
    end
    output.string.should_not match("three")
  end

  after do
    FileUtils.rm_r("#{ENV['IRB_MEMO_DIR']}") if File.directory?("#{ENV['IRB_MEMO_DIR']}")
  end

end
