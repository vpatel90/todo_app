class FileManager
  attr_accessor :total_lists, :titles, :all_lists_in_file
  def initialize
    csvobj = CSV.open(Messages::FILE,"a+")
    @all_lists_in_file = csvobj.read
    @total_lists = 0
    @titles = []
    add_titles(all_lists_in_file)
  end

  def add_titles(lists)
    lists.each do |item|
      @total_lists += 1
      @titles.push(item[0])
    end
  end

  def get_todo_at_index(index)
    todo_list = []
    max = @all_lists_in_file[index-1].index(Messages::SPLITTER)
    (0...max).each do |item|
      todo_list.push(@all_lists_in_file[index-1][item])
    end
    return todo_list
  end

  def get_done_at_index(index)
    done_list = []
    arr = @all_lists_in_file[index-1]
    min = arr.index(Messages::SPLITTER)
    (min + 1...arr.length).each do |item|
      done_list.push(arr[item])
    end
    #require 'pry' ; binding.pry
    return done_list
  end

  def make_arr(title,to_do_list,done_list)
    arr = []
    arr.push(title)
    arr = arr + to_do_list
    arr.push(Messages::SPLITTER)
    arr = arr + done_list
    return arr
  end

  def write_file(title,to_do_list,done_list)
    arr = make_arr(title,to_do_list,done_list)
    new_file = true
    csv = File.open(Messages::FILE, "w+")
    @all_lists_in_file.each do |item|
      if item[0] == arr[0]
        item = arr
        new_file = false
      end
      item = item.join(",")
      csv << item + "\n"
    end
    if new_file == true
      csv << arr.join(",") +"\n"
    end
  end
end
