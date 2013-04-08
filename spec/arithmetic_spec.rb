require 'spec_helper'
require 'arithmetic'
require 'benchmark'

describe Arithmetic do

  describe ".is_prime?" do

    context "when a given integer is prime" do

      let(:primes) { [2, 3, 7, 23] }

      it "returns true" do
        expect(primes.all? { |p| Arithmetic.is_prime?(p) }).to be_true
      end
    end

    context "when a given integer is composite" do

      let(:composites) { [1, 4, 9, 12] }

      it "returns false" do
        expect(composites.any? { |c| Arithmetic.is_prime?(c) }).to be_false
      end
    end
  end

  describe ".prime_factors" do

    it "finds the prime factors of a given positive integer" do
      expect(Arithmetic.prime_factors(315)).to eq [3, 3, 5, 7]
    end
  end

  describe ".prime_factors_mult" do

    it "finds the prime factors and their multiplicity of a given positive integer" do
      expect(Arithmetic.prime_factors_mult(315)).to eq [[3, 2], [5, 1], [7, 1]]
    end
  end

  describe ".primes" do

    it "finds a list of prime numbers in a given range" do
      expect(Arithmetic.primes(11, 30)).to eq [11, 13, 17, 19, 23, 29]
    end
  end

  describe ".goldbach" do

    it "finds the two prime numbers that sum up to a given integer" do
      expect(Arithmetic.goldbach(28)).to eq [5, 23]
    end
  end

  describe ".goldbach_list" do

    it "finds a list of all even numbers in a given range and their Goldbach compositions" do
      expect(Arithmetic.goldbach_list(9, 15)).to eq [[10, [3, 7]], [12, [5, 7]], [14, [3, 11]]]
    end

    context "when an integer limit is given" do

      it "finds Goldbach compositions whose primes are both bigger than the limit" do
        expect(Arithmetic.goldbach_list(1, 1500, 50)).to eq [[992, [73, 919]], [1382, [61, 1321]]]
      end
    end
  end

  describe ".gcd" do

    it "finds the greatest common divisor of two positive integers" do
      expect(Arithmetic.gcd(36, 63)).to eq 9
    end
  end

  describe ".coprime?" do

    context "when two positive integers are coprime" do

      it "returns true" do
        expect(Arithmetic.coprime?(35, 64)).to be_true
      end
    end

    context "when two positive integers are not coprime" do

      it "returns false" do
        expect(Arithmetic.coprime?(35, 63)).to be_false
      end
    end
  end

  describe ".totient_phi" do

    it "calculates Euler's totient function" do
      expect(Arithmetic.totient_phi(10)).to be 4
    end

    it "uses the most primitive method" do
      Arithmetic.should_receive(:coprime?).at_least(:once).and_call_original
      Arithmetic.totient_phi(10)
    end
  end

  describe ".phi" do

    it "calculates Euler's totient function" do
      expect(Arithmetic.phi(10)).to be 4
    end

    it "uses smarter way than .totient_phi does" do
      Arithmetic.should_receive(:prime_factors_mult).and_call_original
      Arithmetic.phi(10)
    end

    let(:t1) { Benchmark.realtime { Arithmetic.totient_phi(10090) } }
    let(:t2) { Benchmark.realtime { Arithmetic.phi(10090) } }

    it "runs faster than .totient_phi" do
      expect(t2).to be < t1
    end
  end
end
