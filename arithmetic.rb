require 'prime'

module Arithmetic

  def self.is_prime?(x)
    x.prime?
  end

  def self.prime_factors(x)
    x.prime_division.flat_map { |p, m| [p] * m }
  end

  def self.prime_factors_mult(x)
    x.prime_division
  end

  def self.primes(from, to)
    Prime.take_while { |p| p <= to }.drop_while { |p| p < from }
  end

  def self.goldbach(x)
    return nil if x.odd?

    Prime.each do |p|
      break [p, x - p] if (x - p).prime?
    end 
  end

  def self.goldbach_list(from, to, limit = 2)
    (from..to).select(&:even?)
              .map { |x| [x, goldbach(x)] }
              .select { |p| p.last.all? { |p| p > limit } }
  end

  def self.gcd(x, y)
    x.gcd(y)
  end

  def self.coprime?(x, y)
    x.gcd(y) == 1
  end

  def self.totient_phi(x)
    (1...x).count { |r| coprime?(x, r) }
  end

  def self.phi(x)
    prime_factors_mult(x).flat_map { |p, m| [p - 1, p ** (m - 1)] }.reduce(:*)
  end
end
