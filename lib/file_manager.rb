class FileManager
  attr_accessor :saved_todo, :saved_complete, :total_lists, :titles, :all_lists_in_file
  def initialize
    csvobj = CSV.open(Messages::FILE)
    @all_lists_in_file = csvobj.read
    @total_lists = 0
    @saved_todo = []
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

  def get_lists(csv, all_lists_in_file)
    csv.each do |item|
      if item != Messages::SPLITTER
        all_lists_in_file.push(item)
      end
    end
  end

  def write_file(title,to_do_list,done_list)
    arr = []
    arr.push(title)
    arr = arr + to_do_list
    arr.push(Messages::SPLITTER)
    arr = arr + done_list
    csv = File.open(Messages::FILE, "w+")
    @all_lists_in_file.each do |item|
      if item[0] == arr[0]
        item = arr
      end
      item = item.join(",")
      csv << item + "\n"
    end
  end
end
