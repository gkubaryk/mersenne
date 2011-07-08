#!/usr/bin/ruby

def factorize(orig)
  factors = {}
  factors.default = 0     # return 0 instead nil if key not found in hash
  n = orig
  i = 2
  sqi = 4                 # square of i
  while sqi <= n do
    while n.modulo(i) == 0 do
      n /= i
      factors[i] += 1
    end
    # we take advantage of the fact that (i +1)**2 = i**2 + 2*i +1
    sqi += 2 * i + 1
    i += 1
  end

  if (n != 1) && (n != orig)
    factors[n] += 1
  end

  factors
end

def printkhash(orig, factorcount)
  print "k = "
  if factorcount.length == 0
    print "PRIME"
  else
    # I'm sure there's a cleaner/better way to do this.
    last, throwaway = factorcount.sort.last

    # Print the factors.
    factorcount.sort.each do |factor,exponent|
      print factor
      if exponent > 1
        print "^", exponent
      end
      print " * " if factor != last  # don't need multiplication sign after last factor
    end
  end

  puts
end
