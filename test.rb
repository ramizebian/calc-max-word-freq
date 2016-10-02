class LineAnalyzer

  attr_reader :content, :line_number, :highest_wf_words, :highest_wf_count

  def initialize(content, line_number)
    @content = content
    @line_number = line_number
    self.calculate_word_frequency(content)
  end

  def calculate_word_frequency(content)
    word_frequency_hash = Hash.new(0)

    content.split.each do |word|
      word_frequency_hash[word.downcase] +=1
    end

    @highest_wf_count = word_frequency_hash.values.max
    @highest_wf_words = word_frequency_hash.select { |key, value| value == word_frequency_hash.values.max}.keys

  end

end

class Solution

  attr_reader  :analyzers, :highest_count_across_lines, :highest_count_words_across_lines

  def initialize
    @analyzers = []
  end

  def analyze_file        
    if File.exist? 'test.txt'
        File.foreach( 'test.txt' ).each_with_index do |line, index|          
          @analyzers << LineAnalyzer.new(line, index)          
        end
    end
  end

  def calculate_line_with_highest_frequency
    @highest_count_across_lines = 0
    @highest_count_words_across_lines = []
  
    @analyzers.each do |la|
      if la.highest_wf_count > @highest_count_across_lines
        @highest_count_across_lines = la.highest_wf_count
      end
    end

    @analyzers.each do |la|
      if la.highest_wf_count == @highest_count_across_lines
        @highest_count_words_across_lines << la
      end
    end    
  end

  def print_highest_word_frequency_across_lines 
    puts "The following words have the highest word frequency per line:"    
    @highest_count_words_across_lines.each { |word| puts "#{word.highest_wf_words} (appears in line #{word.line_number}) "}
  end

end



solution = Solution.new
solution.analyze_file
solution.calculate_line_with_highest_frequency
solution.print_highest_word_frequency_across_lines