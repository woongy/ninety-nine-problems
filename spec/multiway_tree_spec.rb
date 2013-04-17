require 'spec_helper'
require 'multiway_tree'

describe MultiwayTree do

  describe ".tree?" do

    context "when given a tree" do

      let(:t) { T(:a,[T(:f, [T(:g, [])]), T(:c, []), T(:b, [T(:d, []), T(:e, [])])]) }

      it "returns true" do
        expect(MultiwayTree.tree?(t)).to be_true
      end
    end

    context "when given a non-tree" do

      let(:t) { T(:a, T(:b)) }

      it "returns false" do
        expect(MultiwayTree.tree?(t)).to be_false
      end
    end
  end

  describe ".nnodes" do

    {
      T(:a,[T(:f, [T(:g, [])]), T(:c, []), T(:b, [T(:d, []), T(:e, [])])]) => 7,
      T(:a, [T(:f, [])]) => 2
    }.each do |t, expected|

      it "counts the nodes of a multiway tree" do
        expect(MultiwayTree.nnodes(t)).to eq expected
      end
    end
  end
end
