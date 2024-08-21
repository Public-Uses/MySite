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
end
