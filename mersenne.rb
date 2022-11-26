#!/usr/bin/env ruby
require './factorize'

File.open("full.tsv") do |f|
  total_credit = 0.0
  count = 0
  factor_cmd_available = `bash -c 'type -P factor'`.length > 0
  f.each_line do |row|
    machine, exponent, type, date, age, factor, credit = row.split(/\t/)

    factor = factor.split(' ')[1] if factor =~ /Factor/ # new format
    factor = factor.to_i
    exponent = exponent.to_i
    total_credit += credit.to_f
    count += 1

    bits = Math::log(factor)/Math::log(2)
    bits = Integer(bits * 100) / Float(100)

    text = "has factor"

    # Factors take the form 2kp+1, where p is the exponent. We are interested in k.
    k = (factor - 1) / exponent / 2
    puts "M#{exponent} #{text} #{factor} (#{bits} bits)"

    # too large to use naive ruby factoring, use factor from coreutils and hope the output format doesn't change
    if bits > 125
      if factor_cmd_available
        splits = `factor #{k}`.strip.delete_prefix("#{k}: ").split(' ').map(&:to_i).tally
        printkhash(k, splits)
      else
        puts "*** Skipping M#{exponent}'s factor (#{factor}) because #{bits} bits is too large."
      end
    else
      printkhash(k, factorize(k))
    end

    print "\n"
  end

  puts '-'*40
  puts "Final stats: #{total_credit} GHz-days of credit for #{count} factors found"
end
