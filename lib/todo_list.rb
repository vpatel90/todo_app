class ToDoList
  def initialize(file, io)
    @file = file
    @io = io
    @todo_list = @file.saved_todo.dup
    @done_list = []
  end

  def list_menu(error = nil)
    @io.puts "(A)dd item to list"
    @io.puts "(C)omplete an item"
    @io.puts "(D)elete an item"
    @io.puts "(S)ave"
    @io.puts "(Q)uit"
    #puts @file.saved_complete
    option = get_input(Messages::OPTIONS)
    if option.upcase == "A"
      input = get_input(Messages::ADD)
      add_item(input)
    elsif option.upcase == "C"
      input = get_input(Messages::COMPLETE)
      completed = complete_item(input)
      add_to_done(completed)
    elsif option.upcase == "D"
      input = get_input(Messages::DELETE)
      delete_item(input)
    elsif option.upcase == "S"
      @file.write_file(@todo_list, @done_list)
      exit
    elsif option.upcase == "Q"
      exit
    end
    display_todo
  end

  def get_input(message)
    @io.puts(message)
    @io.print "> "
    @io.gets
  end

  def display_todo
    system`clear`
    @todo_list.each_with_index do |item, index|
      @io.print "#{index+1}. #{item}"
      @io.puts "#{index+1}. #{@done_list[index]}".rjust(20," ")
    end
    list_menu
  end

  def add_item(item)
    @todo_list.push(item)
  end

  def complete_item(input)
    @todo_list.slice!(input.to_i-1)
  end

  def add_to_done(item)
    @done_list.push(item)
  end

  def delete_item(item)
    @todo_list.slice!(item.to_i-1)
  end
end
