require 'spec_helper'
require 'binary_tree'

describe BinaryTree do

  describe ".tree?" do

    context "when given a tree" do

      [
        :nil,
        [:a, :nil, :nil],
        [:a, [:b, :nil, :nil], :nil]
      ].each do |t|

        it "returns true" do
          expect(BinaryTree.tree?(t)).to be_true
        end
      end
    end

    context "when given a non-tree" do

      let(:t) { [:a, [:b, :nil, :nil]] }

      it "returns false" do
        expect(BinaryTree.tree?(t)).to be_false
      end
    end
  end
end