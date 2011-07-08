#!/usr/bin/ruby
require 'factorize'
require 'csv'

#factors = { 1992337, 51860364369830753274943,
#            1992163, 10008305505011786857
#          }
#
#factors.each do |exponent, found_factor|
#  bits = Math::log(found_factor)/Math::log(2)
#  puts "M#{exponent} has factor #{found_factor} with #{bits} bits"
#end


CSV.foreach("factor_info.csv") do |row|
  machine, exponent, type, date, age, factor, credit = row
  bits = Math::log(factor)/Math::log(2)
  factor = factor.to_i
  exponent = exponent.to_i
  next if exponent > 2000000
  next if exponent < 1990000
  k = (factor - 1) / exponent / 2
  puts "M#{exponent} has factor #{factor} with #{bits} bits, k=#{k}"
  printkhash(k, factorize(k))
#  puts "#{machine} found #{factor} for M#{exponent} on #{date}"
  
end
