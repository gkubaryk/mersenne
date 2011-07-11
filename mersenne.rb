#!/usr/bin/env ruby
require 'factorize'

File.open("full.tsv") do |f|
  f.each_line do |row|
    machine, exponent, type, date, age, factor, credit = row.split(/\t/)
    bits = Math::log(factor)/Math::log(2)
    bits = Integer(bits * 100) / Float(100)

    factor = factor.to_i
    exponent = exponent.to_i

    if bits > 100
      puts "*** Skipping M#{exponent}'s factor (#{factor}) because #{bits} bits is too large."
      print "\n"
      next
    end

    text = "has factor"

    k = (factor - 1) / exponent / 2
    puts "M#{exponent} #{text} #{factor} (#{bits} bits)"
    #puts "M#{exponent} #{text} #{factor} with #{bits} bits, k=#{k}"
    #puts "M#{exponent} #{text} #{factor} (via #{type}) with #{bits} bits, k=#{k}"
    printkhash(k, factorize(k))
    print "\n"
  end
end
