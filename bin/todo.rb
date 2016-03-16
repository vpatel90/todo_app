#!/usr/bin/ruby

require_relative '../lib/io_adapter'
require_relative '../lib/console_input'
require_relative '../lib/console_output'
require_relative '../lib/messages'
require_relative '../lib/todo_list'
require_relative '../lib/file_manager'
require 'CSV'

class MainMenu
  def initialize(file,io,application)
    @file = file
    @io = io
    @application = application
  end

  def menu
    @io.clear
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
        @application.list_titles
      end
    when "C"
      @application.create_title(Messages::TITLE)
    when "E"
      exit
    else
      input = get_input(Messages::OPTIONS)
      evaluate(input)
    end
    menu
  end
end

file = FileManager.new
input = ConsoleInput.new
output = ConsoleOutput.new
io = IOAdapter.new(input,output)
application = ToDoList.new(file,io)
## Comment out below part for test!
MainMenu.new(file,io,application).menu
