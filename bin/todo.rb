#require_relative '../lib/'
require_relative '../lib/io_adapter'
require_relative '../lib/console_input'
require_relative '../lib/console_output'
require_relative '../lib/messages'
require_relative '../lib/todo_list'
require_relative '../lib/file_manager'
require 'CSV'

class MainMenu
  def initialize
    @file = FileManager.new
    input = ConsoleInput.new
    output = ConsoleOutput.new
    @io = IOAdapter.new(input,output)
    @application = ToDoList.new(@file,@io)
  end

  def menu
    @io.puts_list ["You have #{@file.total_lists} lists", "(V)iew a list",
                  "(C)reate a new list", "(E)xit"]
    input = get_input(Messages::OPTIONS)
    evaluate(input)
  end

  def get_input(message)
    @io.puts(message)
    @io.print "> "
    @io.gets
  end



  def evaluate(input)
    case input.upcase
    when "V"
      if @file.total_lists == 0
        @io.puts "No lists available"
      else
        @appliation.list_titles
      end
    when "C"

    when "X"
      exit
    else
      input = get_input(Messages::OPTIONS)
      evaluate(input)
    end
    menu
  end
end


MainMenu.new.menu
