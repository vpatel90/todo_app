require 'minitest/autorun'
require 'minitest/pride'

require_relative '../bin/todo.rb'

class TestTODOApp < Minitest::Test
  def setup
    @file = FileManager.new
    input = ConsoleInput.new
    output = ConsoleOutput.new
    io = IOAdapter.new(input,output)
    @application = ToDoList.new(@file,io)
    @main_menu = MainMenu.new(@file,io,@application)
  end

  def test_add_item
    @application.todo_list = []
    expected = ["item"]
    assert_equal(expected, @application.add_item("item"))
  end

  def test_complete_item
    @application.todo_list = ["item1", "item2", "item3"]
    expected = "item2"
    assert_equal(expected, @application.complete_item(2))
  end

  def test_done_item
    @application.done_list = []
    expected = ["item"]
    assert_equal(expected, @application.add_to_done("item"))
  end

  def test_make_arr

    expected = ["title", "item1", "&&&&&", "item2"]
    title = "title"
    to_do_list = ["item1"]
    done_list = ["item2"]
    assert_equal(expected, @file.make_arr(title,to_do_list,done_list))

  end

  def test_get_todo
    @file.all_lists_in_file = [["item1","item2","&&&&&","item7"],["item3","item4"]]
    expected = ["item1", "item2"]
    assert_equal(expected, @file.get_todo_at_index(1))

  end

  def test_get_done
    @file.all_lists_in_file = [["item1","item2","&&&&&","item7"],["item3","item4"]]
    expected = ["item7"]
    assert_equal(expected, @file.get_done_at_index(1))
  end

  def test_add_titles
    list = [["item1","item2","&&&&&","item7"],["item3","item4"]]
    @file.titles = []
    assert_equal(list, @file.add_titles(list))
  end


end
