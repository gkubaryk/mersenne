#!/usr/bin/env ruby
require 'factorize'

File.open("full.tsv") do |f|
  f.each_line do |row|
    machine, exponent, type, date, age, factor, credit = row.split(/\t/)
    bits = Math::log(factor)/Math::log(2)
    bits = Integer(bits * 100) / Float(100)

    factor = factor.to_i
    exponent = exponent.to_i

    # Arbitrary limit; feel free to remove, but factoring large numbers can be slow
    if bits > 90
      puts "*** Skipping M#{exponent}'s factor (#{factor}) because #{bits} bits is too large."
      print "\n"
      next
    end

    text = "has factor"

    # Factors take the form 2kp+1, where p is the exponent. We are interested in k.
    k = (factor - 1) / exponent / 2
    puts "M#{exponent} #{text} #{factor} (#{bits} bits)"
    printkhash(k, factorize(k))
    print "\n"
  end
end
