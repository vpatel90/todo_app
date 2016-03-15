#require_relative '../lib/'
require_relative '../lib/io_adapter'
require_relative '../lib/console_input'
require_relative '../lib/console_output'
require_relative '../lib/messages'
require 'CSV'

class FileManager
  attr_accessor :saved_todo, :saved_complete, :user
  def initialize
    csv = File.open(Messages::FILE, "r")
    all_lists_in_file = []
    get_lists(csv, all_lists_in_file)
    @saved_todo = all_lists_in_file
    #@user = user
  end

  def get_lists(csv, all_lists_in_file)
    csv.each do |item|
      if item != Messages::SPLITTER
        all_lists_in_file.push(item)
      end
    end
  end

  def write_file(to_do_list)
    csv = File.open(Messages::FILE, "w+")
    to_do_list.each do |item|
      item = item
      csv << item
    end
    csv << "\n"
    csv << Messages::SPLITTER
  end
end

class ToDoList
  def initialize(file, io)
    @file = file
    @io = io
    @todo_list = @file.saved_todo.dup
    @done_list = []
  end

  def menu(error = nil)
    @io.puts "(A)dd item to list"
    @io.puts "(C)omplete an item"
    @io.puts "(S)ave"
    @io.puts "(Q)uit"
    option = get_input(Messages::OPTIONS)
    if option.upcase == "A"
      input = get_input(Messages::ADD)
      add_item(input)
      display_todo
    elsif option.upcase == "C"
      input = get_input(Messages::COMPLETE)
      completed = complete_item(input)
      add_to_done(completed)
      display_todo
    elsif option.upcase == "S"
      @file.write_file(@todo_list)
      exit
    elsif option.upcase == 4
      exit
    end
  end

  def get_input(message)
    @io.puts(message)
    @io.print "> "
    @io.gets
  end

  def display_todo
    system`clear`
    @todo_list.each_with_index{|item, index| @io.puts "#{index+1}. #{item}"}
    menu
  end

  def add_item(item)
    @todo_list.push(item)
  end

  def complete_item(input)
    @todo_list.slice(input-1)
  end

  def add_to_done(item)
    @done_list.push(item)
  end
end

file = FileManager.new
input = ConsoleInput.new
output = ConsoleOutput.new
io = IOAdapter.new(input,output)
ToDoList.new(file,io).display_todo
