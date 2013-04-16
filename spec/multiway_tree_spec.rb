require 'spec_helper'
require 'multiway_tree'

describe MultiwayTree do

  describe ".tree?" do

    context "when given a tree" do

      let(:t) do
        [:a, [
               [:f, [
                      [:g, []]
                    ]],
               [:c, [
                    ]],
               [:b, [
                      [:d, []],
                      [:e, []]
                    ]]
             ]]
      end

      it "returns true" do
        expect(MultiwayTree.tree?(t)).to be_true
      end
    end

    context "when given a non-tree" do

      let(:t) { [:a, [:b]] }

      it "returns false" do
        expect(MultiwayTree.tree?(t)).to be_false
      end
    end
  end
end
