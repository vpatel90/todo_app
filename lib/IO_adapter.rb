class IOAdapter

  def initialize(input, output)
    @input = input
    @output = output
  end

  def gets
    @input.gets
  end

  def print(msg)
    @output.print msg
  end

  def puts(msg)
    @output.puts msg
  end

  def puts_list(arr)
    divider
    arr.each do |item|
      item = " " * ((@width.to_i-30)/2) + item
      puts item
    end
    divider
  end

  def divider
    puts ""
    puts Messages::DIV * @width.to_i
    puts ""
  end

  def puts_list_with_num(arr)
    divider
    arr.each_with_index do |item,index|
      str =  "#{index+1}. #{item}"
      str = " " * ((@width.to_i-30)/2) + str
      puts str
    end
    divider
  end

  def clear
    @width = `tput cols`
    puts`clear`
    if @width.to_i > 75
      Messages::HEADER.each do |line|
        line = " " * ((@width.to_i-75)/2) + line
        puts line
      end
    else
      title_art.each do |line|
        puts Messages::HEADER
      end
    end
  end

end
