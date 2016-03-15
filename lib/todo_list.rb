class ToDoList
  def initialize(file, io)
    @file = file
    @io = io
    @todo_list = []
    @done_list = []
  end

  def list_titles
    @io.puts_list_with_num(@file.titles)
    choice = get_input(Messages::TITLEOPTIONS)
    get_list(choice, @file.titles.length)
  end

  def get_list(choice, num_titles)
    if choice.to_i == 0 || choice.to_i > num_titles
      @io.puts "Invalid choice"
      list_titles
    else
      @todo_list = @file.all_lists_in_file[choice-1]
      display_todo
  end

  def list_menu(error = nil)
    @io.puts "(A)dd item to list"
    @io.puts "(C)omplete an item"
    @io.puts "(D)elete an item"
    @io.puts "(S)ave"
    @io.puts "(Q)uit"
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
      return
    elsif option.upcase == "Q"
      return
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
    title = @todo_list.shift
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
