require 'sourcify'

module TakeAMemo
    
  IRB_MEMO_DIR = ENV['IRB_MEMO_DIR'] || "#{ENV['HOME']}/.irb_memos" 
  
  def take_a_memo(title, &block)
      unless block_given?
          puts "nothing to remember here!"
          return
    end
    file = create_file(title)
    file.write(block.to_raw_source)
    file.close
    execute_commands(file)  
  end
 
  def play_it_back(memo)
    unless file = File.open("#{IRB_MEMO_DIR}/#{memo.gsub(" ", "_")}.rb")
        puts "couldn't find file for #{memo}"
        return
    end
    execute_commands(file)
  end
  
  
  def show_my_memos
    unless File.exists?(IRB_MEMO_DIR) and Dir.entries(IRB_MEMO_DIR).size > 0
        puts "you have no saved memos"
        return
    end
    puts %Q|Here's your memos:\n|
    puts Dir.entries(IRB_MEMO_DIR).reject {|m| m =~ /^\./ }.map {|m| "\t - #{m.gsub(".rb", "").gsub("_", " ")}" }.join("\n") 
  end
  
  def trash_this_memo(memo)
    unless File.exists?("#{IRB_MEMO_DIR}/#{memo.gsub(" ", "_")}.rb")
        puts "couldn't find file to remove for #{memo}"
    end
    FileUtils.rm("#{IRB_MEMO_DIR}/#{memo.gsub(" ", "_")}.rb")
  end
  
  private 
  
  
  def create_file(title) 
    FileUtils.mkdir_p(IRB_MEMO_DIR) unless File.exists?(IRB_MEMO_DIR)
    File.new("#{IRB_MEMO_DIR}/#{title.gsub(" ", "_")}.rb", "w")
  end
  
  def execute_commands(file)
    cmd = IO.read(file.path)
    output = eval cmd
    puts "memo returned: #{output.call}"
  end

end