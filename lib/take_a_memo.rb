module TakeAMemo

  def take_a_memo(title, &block) 
    puts "nothing to remember here!" unless block_given?
  end
  
  

end