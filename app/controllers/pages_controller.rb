class PagesController < ApplicationController
	def caesar_cipher(text, shift)
	  result = ""
	  text.each_char do |char|
	    if char.match(/[A-Z]/)
	      shifted_char = ((char.ord - 'A'.ord + shift) % 26 + 'A'.ord).chr
	      result += shifted_char
	    elsif char.match(/[a-z]/)
	      shifted_char = ((char.ord - 'a'.ord + shift) % 26 + 'a'.ord).chr
	      result += shifted_char
	    else
	      result += char
	    end
	  end
	  result
	end
	output = caesar_cipher("What a string!", 5)
	puts output  # => "Bmfy f xywnsl!"	

	def substrings(word, dictionary)
	  result = Hash.new(0)
	  word = word.downcase
	  dictionary.each do |substring|
	    substring = substring.downcase
	    matches = word.scan(substring).length
	    result[substring] += matches if matches > 0
	  end
	  result
	end
	dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
	puts substrings("below", dictionary)
	puts substrings("Howdy partner, sit down! How's it going?", dictionary)
end
