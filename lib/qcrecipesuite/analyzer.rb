#!/usr/bin/env ruby
# encoding: UTF-8
module QCRecipeSuite
  class Analyzer
    def initialize(output)
      @output = output
    end

    def compare(oldfile, newfile)
      oldset = Dataset.new(oldfile, @output)
      newset = Dataset.new(newfile, @output)

      puts "FULL SET " + (oldset.similar_to?(newset) ? "PASSED" : "FAILED")
    end

    def puts string
      @output.puts string
    end
  end
end
