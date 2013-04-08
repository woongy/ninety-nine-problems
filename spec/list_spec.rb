require 'spec_helper'
require 'list'

describe List do

  describe ".last" do

    let(:x) { %i(a b c d e) }

    it "finds the last elements of a list" do
      expect(List.last(x)).to eq :e
    end
  end

  describe ".last_but_one" do

    let(:x) { %i(a b c d e) }

    it "finds the last but one element of a list" do
      expect(List.last_but_one(x)).to eq :d
    end
  end

  describe ".element_at" do

    let(:x) { %i(a b c d e) }

    it "finds the K'th element of a list" do
      expect(List.element_at(x, 3)).to eq :c
    end
  end

  describe ".length" do

    let(:x) { %i(a b c d e) }

    it "finds the number of elements of a list" do
      expect(List.length(x)).to eq 5
    end
  end

  describe ".reverse" do

    let(:x) { %i(a b c d e) }

    it "reverses a list" do
      expect(List.reverse(x)).to eq %i(e d c b a)
    end
  end

  describe ".palindrome?" do

    context "when a list is a palindrome" do

      let(:x) { %i(a b c b a) }

      it "returns true" do
        expect(List.palindrome?(x)).to be_true
      end
    end

    context "when a list is not a palindrome" do

      let(:x) { %i(a b c d e) }

      it "returns false" do
        expect(List.palindrome?(x)).to be_false
      end
    end
  end

  describe ".flatten" do

    let(:x) { [:a, [:b, [:c, :d], :e]] }

    it "flattens a nested list structure" do
      expect(List.flatten(x)).to eq %i(a b c d e)
    end
  end

  describe ".compress" do

    let(:x) { %i(a a a a b c c a a d e e e e) }

    it "eliminates consecutive duplicates of list elements" do
      expect(List.compress(x)).to eq %i(a b c a d e)
    end
  end

  describe ".pack" do

    let(:x) { %i(a a a a b c c a a d e e e e) }

    it "packs consecutive duplicates of list elements into sublists" do
      expect(List.pack(x)).to eq [%i(a a a a), %i(b), %i(c c), %i(a a), %i(d), %i(e e e e)]
    end
  end

  describe ".encode" do

    let(:x) { %i(a a a a b c c a a d e e e e) }

    it "returns run-length encoding of a list" do
      expect(List.encode(x)).to eq [[4, :a], [1, :b], [2, :c], [2, :a], [1, :d], [4, :e]]
    end

    it "calls .pack internally" do
      List.should_receive(:pack).and_call_original
      List.encode(x)
    end
  end

  describe ".encode_modified" do

    let(:x) { %i(a a a a b c c a a d e e e e) }

    it "returns modified run-length encoding a list using .encode" do
      expect(List.encode_modified(x)).to eq [[4, :a], :b, [2, :c], [2, :a], :d, [4, :e]]
    end

    it "calls .encode internally" do
      List.should_receive(:encode).and_call_original
      List.encode_modified(x)
    end
  end

  describe ".decode" do

    let(:x) { %i(a a a a b c c a a d e e e e) }
    let(:encoded) { List.encode_modified(x) }

    it "decodes a run-length encoded list" do
      encoded
      expect(List.decode(encoded)).to eq x
    end
  end

  describe ".encode_direct" do

    let(:x) { %i(a a a a b c c a a d e e e e) }

    it "returns run-length encoding of a list" do
      expect(List.encode_direct(x)).to eq [[4, :a], :b, [2, :c], [2, :a], :d, [4, :e]]
    end

    it "does not call .pack internally" do
      List.should_not_receive(:pack)
      List.encode_direct(x)
    end
  end

  describe ".dupli" do

    let(:x) { %i(a b c) }

    it "duplicates the elements of a list" do
      expect(List.dupli(x)).to eq %i(a a b b c c)
    end

    context "when a number argument is given" do
      it "duplicate the elements of a list a given number of times" do
        expect(List.dupli(x, 3)).to eq %i(a a a b b b c c c)
      end
    end
  end

  describe ".drop" do

    let(:x) { %i(a b c d e f g h i k) }

    it "drops every N'th element from a list" do
      expect(List.drop(x, 3)).to eq %i(a b d e g h k)
    end
  end

  describe ".split" do

    let(:x) { %i(a b c d e f g h i k) }

    it "splits a list into two parts" do
      expect(List.split(x, 3)).to eq [%i(a b c), %i(d e f g h i k)]
    end
  end

  describe ".slice" do

    let(:x) { %i(a b c d e f g h i k) }

    it "extracts a slice from a list" do
      expect(List.slice(x, 3, 7)).to eq %i(c d e f g)
    end
  end

  describe ".rotate" do

    let(:x) { %i(a b c d e f g h) }

    it "rotates a list N places to the left" do
      expect(List.rotate(x, 3)).to eq %i(d e f g h a b c)
    end

    context "when N is negative" do

      it "rotates a list -N places to the right" do
        expect(List.rotate(x, -2)).to eq %i(g h a b c d e f)
      end
    end
  end

  describe ".remove_at" do

    let(:x) { %i(a b c d) }

    it "removes the K'th element from a list" do
      expect(List.remove_at(x, 2)).to eq [:b, %i(a c d)]
    end
  end

  describe ".insert_at" do

    let(:x) { %i(a c d e) }

    it "inserts an element at a given position into a list" do
      expect(List.insert_at(x, 2, :b)).to eq %i(a b c d e)
    end
  end

  describe ".range" do

    it "creates a list containing all integers within a given range" do
      expect(List.range(4, 9)).to eq [4, 5, 6, 7, 8, 9]
    end
  end

  describe ".rnd_select" do

    context "when a list is given" do

      it "extracts a given number of randomly selected elements from a list"
    end

    context "when a range is given" do

      it "draws N different random numbers from the given range 1..M"
    end
  end

  describe ".rnd_permu" do

    it "generates a random permutation of the elements of a list"
  end

  describe ".combination" do

    let(:x) { %i(a b c) }

    it "generates the combinations of K distinct objects chosen from the N elements of a list" do
      expect(List.combination(x, 2)).to eq [%i(a b), %i(a c), %i(b c)]
    end
  end

  describe ".group" do

    let(:x) { %i(a b c d e f g h i) }

    it "groups the elements of a set into disjoint subsets" do
      expect(List.group(x, [2, 2, 5])).to eq [%i(a b), %i(c d), %i(e f g h i)]
    end
  end

  describe ".lsort" do

    let(:x) { [%i(a b c), %i(d e), %i(f g h), %i(d e), %i(i j k l), %i(m n), %i(o)] }

    it "sorts a list of lists according to length of sublists" do
      expect(List.lsort(x)).to eq [%i(o), %i(d e), %i(d e), %i(m n), %i(a b c), %i(f g h), %i(i j k l)]
    end
  end

  describe ".lfsort" do

    let(:x) { [%i(a b c), %i(d e), %i(f g h), %i(d e), %i(i j k l), %i(m n), %i(o)] }

    it "sorts a list of lists according to length frequency of sublists" do
      expect(List.lfsort(x)).to eq [%i(i j k l), %i(o), %i(a b c), %i(f g h), %i(d e), %i(d e), %i(m n)]
    end
  end
end
