require 'spec_helper'
require 'logic'

describe Logic do

  describe ".table" do

    {
      {
        n: 2,
        expression: -> (a, b) { a && (a || !b) }
      } => {
        [true, true] => true,
        [true, false] => true,
        [false, true] => false,
        [false, false] => false
      },
      {
        n: 3,
        expression: -> (a, b, c) { (a && (b || c)) == (a && b || a && c) }
      } => {
        [true, true, true] => true,
        [true, true, false] => true,
        [true, false, true] => true,
        [true, false, false] => true,
        [false, true, true] => true,
        [false, true, false] => true,
        [false, false, true] => true,
        [false, false, false] => true
      }
    }.each do |input, expected|

      it "returns the truth table for a logical expression in #{input[:n]} variables" do
        expect(Logic.table(input[:expression])).to eq expected
      end
    end
  end

  describe ".gray" do

    {
      1 => %w(0 1),
      2 => %w(00 01 11 10),
      3 => %w(000 001 011 010 110 111 101 100)
    }.each do |n, expected|

      it "computes #{n}-bit gray code" do
        expect(Logic.gray(n)).to eq expected
      end
    end
  end

  describe ".huffman" do

    let(:freq_table) { { a: 45, b: 13, c: 12, d: 16, e: 9, f: 5 } }
    let(:expected) { { a: '0', b: '101', c: '100', d: '111', e: '1101', f: '1100' } }

    it "returns Huffman code table for a given frequency table" do
      expect(Logic.huffman(freq_table)).to eq expected
    end
  end
end
