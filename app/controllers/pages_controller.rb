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

	def stock_picker(prices)
	  min_price = prices[0]
	  min_day = 0
	  max_profit = 0
	  best_days = [0, 0]
	  prices.each_with_index do |price, day|
	    if price < min_price
	      min_price = price
	      min_day = day
	    end
	    profit = price - min_price
	    if profit > max_profit
	      max_profit = profit
	      best_days = [min_day, day]
	    end
	  end
	  best_days
	end
	puts stock_picker([17,3,6,9,15,8,6,1,10]).inspect

	def bubble_sort(array)
	  n = array.length
	  (n - 1).times do
	    swapped = false
	    (n - 1).times do |i|
	      if array[i] > array[i + 1]
	        array[i], array[i + 1] = array[i + 1], array[i]
	        swapped = true
	      end
	    end
	    break unless swapped
	  end
	  array
	end
	puts bubble_sort([4, 3, 78, 2, 0, 2]).inspect
end
