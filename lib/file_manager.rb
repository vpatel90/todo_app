class FileManager
  attr_accessor :saved_todo, :saved_complete, :total_lists, :titles
  def initialize
    csvobj = CSV.open(Messages::FILE)
    all_lists_in_file = csvobj.read
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

  def get_lists(csv, all_lists_in_file)
    csv.each do |item|
      if item != Messages::SPLITTER
        all_lists_in_file.push(item)
      end
    end
  end

  def write_file(to_do_list,done_list)
    csv = File.open(Messages::FILE, "w+")
    to_do_list.each do |item|
      csv << item
    end
    csv << "\n"
    csv << Messages::SPLITTER
    done_list.each do |item|
      csv << item
    end
  end
end
