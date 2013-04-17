require 'spec_helper'
require 'binary_tree'

describe BinaryTree do

  describe ".tree?" do

    context "when given a tree" do

      [
        :nil,
        T(:a, :nil, :nil),
        T(:a, T(:b, :nil, :nil), :nil)
      ].each do |t|

        it "returns true" do
          expect(BinaryTree.tree?(t)).to be_true
        end
      end
    end

    context "when given a non-tree" do

      let(:t) { T(:a, T(:b, :nil, :nil)) }

      it "returns false" do
        expect(BinaryTree.tree?(t)).to be_false
      end
    end
  end

  describe ".cbal_trees" do

    let(:expected) do
      [
        T(:x, T(:x, :nil, :nil), T(:x, :nil, T(:x, :nil, :nil))),
        T(:x, T(:x, :nil, :nil), T(:x, T(:x, :nil, :nil), :nil)),
        T(:x, T(:x, :nil, T(:x, :nil, :nil)), T(:x, :nil, :nil)),
        T(:x, T(:x, T(:x, :nil, :nil), :nil), T(:x, :nil, :nil))
      ]
    end

    it "generates a list of completely balanced binary trees for a given number of nodes" do
      expect(BinaryTree.cbal_trees(4)).to eq expected
    end
  end

  describe ".symmetric?" do

    context "when given a symmetric tree" do

      let(:t) { T(:a, T(:b, T(:c, :nil, :nil), :nil), T(:d, :nil, T(:e, :nil, :nil))) }

      it "returns true" do
        expect(BinaryTree.symmetric?(t)).to be_true
      end
    end

    context "when given an asymmetric tree" do

      let(:t) { T(:a, T(:b, T(:c, :nil, :nil), :nil), T(:d, T(:e, :nil, :nil), :nil)) }

      it "returns false" do
        expect(BinaryTree.symmetric?(t)).to be_false
      end
    end
  end

  describe ".construct" do

    let(:input) { [3, 2, 5, 7, 1] }
    let(:expected) { T(3, T(2, T(1, :nil, :nil), :nil), T(5, :nil, T(7, :nil, :nil))) }

    it "constructs a binary search from a list of integer numbers" do
      expect(BinaryTree.construct(input)).to eq expected
    end
  end

  describe ".sym_cbal_trees" do

    let(:expected) do
      [
        T(:x,
          T(:x, :nil, T(:x, :nil, :nil)),
          T(:x, T(:x, :nil, :nil), :nil)),
        T(:x,
          T(:x, T(:x, :nil, :nil), :nil),
          T(:x, :nil, T(:x, :nil, :nil)))
      ]
    end

    it "generates a list of symmetric and completely balanced binary trees for a given number of nodes" do
      expect(BinaryTree.sym_cbal_trees(5)).to eq expected
    end

    it "generates 256 symmetric and completely balanced binary trees with 57 nodes" do
      expect(BinaryTree.sym_cbal_trees(57).count).to eq 256
    end

    it "generates 0 symmetric and completely balanced binary trees with an even number of nodes" do
      expect(BinaryTree.sym_cbal_trees(10).count).to eq 0
    end
  end

  describe ".hbal_trees" do

    let(:expected) do
      [
        T(:x, T(:x, :nil, :nil), T(:x, :nil, :nil)),
        T(:x, T(:x, :nil, :nil), :nil),
        T(:x, :nil, T(:x, :nil, :nil))
      ]
    end

    it "generates a list of height-balanced binary trees for a given height" do
      expect(BinaryTree.hbal_trees(2)).to eq expected
    end
  end

  describe ".hbal_min_nodes" do

    it "finds the minimum number of nodes in a height-balanced binary tree of a given height"
  end

  describe ".hbal_max_height" do

    it "finds the maximum height of a height-balanced binary tree with a given number of nodes"
  end

  describe ".hbal_tree_nodes" do

    it "generates a list of height-balanced binary trees with a given number of nodes"
  end

  describe ".count_leaves" do

    let(:t) do
      T(:a,
        T(:b, T(:d, :nil, :nil), T(:e, :nil, :nil)),
        T(:c, :nil, T(:f, T(:g, :nil, :nil), :nil)))
    end

    it "counts the leaves of a binary tree" do
      expect(BinaryTree.count_leaves(t)).to eq 3
    end
  end

  describe ".leaves" do

    let(:t) do
      T(:a,
        T(:b, T(:d, :nil, :nil), T(:e, :nil, :nil)),
        T(:c, :nil, T(:f, T(:g, :nil, :nil), :nil)))
    end

    it "collects the leaves of a binary tree in a list" do
      expect(BinaryTree.leaves(t)).to eq %i(d e g)
    end
  end

  describe ".internals" do

    let(:t) do
      T(:a,
        T(:b, T(:d, :nil, :nil), T(:e, :nil, :nil)),
        T(:c, :nil, T(:f, T(:g, :nil, :nil), :nil)))
    end

    it "collects the inernal nodes of a binary tree in a list" do
      expect(BinaryTree.internals(t)).to eq %i(a b c f)
    end
  end

  describe ".at_level" do

    let(:t) do
      T(:a,
        T(:b, T(:d, :nil, :nil), T(:e, :nil, :nil)),
        T(:c, :nil, T(:f, T(:g, :nil, :nil), :nil)))
    end

    it "collects the nodes at a given level in a list" do
      expect(BinaryTree.at_level(t, 3)).to eq %i(d e f)
    end
  end

  describe ".complete_binary_tree" do

    it "constructs a complete binary tree with a given number of nodes"
  end

  describe ".layout_binary_tree" do

    context "when layout strategy is :inorder" do

    end

    context "when layout strategy is :wide" do

    end

    context "when layout strategy is :compact" do

    end
  end

  describe ".tree_string" do

    context "when given a tree" do

      let(:t) do
        T(:a,
          T(:b, T(:d, :nil, :nil), T(:e, :nil, :nil)),
          T(:c, :nil, T(:f, T(:g, :nil, :nil), :nil)))
      end

      it "returns its string representation" do
        expect(BinaryTree.tree_string(t)).to eq "a(b(d,e),c(,f(g,)))"
      end
    end

    context "when given a string" do

      let(:expected) do
        T("a",
          T("b", T("d", :nil, :nil), T("e", :nil, :nil)),
          T("c", :nil, T("f", T("g", :nil, :nil), :nil)))
      end

      it "constructs the tree represented by it" do
        expect(BinaryTree.tree_string("a(b(d,e),c(,f(g,)))")).to eq expected
      end
    end
  end

  describe ".preorder" do

    let(:t) do
      T("a",
        T("b", T("d", :nil, :nil), T("e", :nil, :nil)),
        T("c", :nil, T("f", T("g", :nil, :nil), :nil)))
    end

    it "constructs the preorder sequence of a given binary tree" do
      expect(BinaryTree.preorder(t)).to eq "abdecfg"
    end
  end

  describe ".inorder" do

    let(:t) do
      T("a",
        T("b", T("d", :nil, :nil), T("e", :nil, :nil)),
        T("c", :nil, T("f", T("g", :nil, :nil), :nil)))
    end

    it "constructs the inorder sequence of a given binary tree" do
      expect(BinaryTree.inorder(t)).to eq "dbeacgf"
    end
  end

  describe ".pre_in_tree" do

    it "constructs the binary tree that has a given preorder sequence and a inorder sequence"
  end

  describe ".tree_dotstring" do

    context "when given a tree" do

      let(:t) do
        T(:a,
          T(:b, T(:d, :nil, :nil), T(:e, :nil, :nil)),
          T(:c, :nil, T(:f, T(:g, :nil, :nil), :nil)))
      end

      it "returns its dotstring representation" do
        expect(BinaryTree.tree_dotstring(t)).to eq "abd..e..c.fg..."
      end
    end

    context "when given a dotstring" do

      let(:expected) do
        T("a",
          T("b", T("d", :nil, :nil), T("e", :nil, :nil)),
          T("c", :nil, T("f", T("g", :nil, :nil), :nil)))
      end

      it "constructs the tree represented by it" do
        expect(BinaryTree.tree_dotstring("abd..e..c.fg...")).to eq expected
      end
    end
  end
end
