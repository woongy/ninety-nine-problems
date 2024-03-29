module Kernel
  def T(*args)
    args
  end
end

module BinaryTree

  def self.tree?(t)
    root, left, right = t

    if root == :nil
      true
    elsif left.nil? || right.nil?
      false
    else
      tree?(left) && tree?(right)
    end
  end

  def self.cbal_trees(n, sym = :x)
    if n == 0
      T(:nil)
    else
      n -= 1
      if n.even?
        t = cbal_trees(n/2)
        t.product(t).map { |left_and_right| T(sym, *left_and_right) }
      else
        t = cbal_trees(n/2)
        u = cbal_trees(n - n/2)
        [
          *t.product(u),
          *u.product(t)
        ].map { |left_and_right| T(sym, *left_and_right) }
      end
    end
  end

  def self.mirror?(t, u)
    root_t, left_t, right_t = t
    root_u, left_u, right_u = u

    if root_t == :nil && root_u == :nil
      true
    elsif [left_t, right_t, left_u, right_u].any?(&:nil?)
      false
    else
      mirror?(left_t, right_u) && mirror?(right_t, left_u)
    end
  end

  def self.symmetric?(t)
    root, left, right = t

    if root == :nil
      true
    else
      mirror?(left, right)
    end
  end

  def self.add(t, value)
    root, left, right = t

    if root == :nil
      T(value, :nil, :nil)
    else
      if value < root
        T(root, add(left, value), right)
      elsif root < value
        T(root, left, add(right, value))
      end
    end
  end

  def self.construct(values)
    values.inject(:nil) { |t, value| add(t, value) }
  end

  def self.sym_cbal_trees(n, sym = :x)
    cbal_trees(n, sym).select { |t| symmetric?(t) }
  end

  def self.hbal_trees(h, sym = :x)
    if h == 0
      [:nil]
    elsif h == 1
      [T(sym, :nil, :nil)]
    else
      t = hbal_trees(h - 1)
      u = hbal_trees(h - 2)
      [
        *t.product(t),
        *t.product(u),
        *u.product(t)
      ].map { |left_and_right| T(sym, *left_and_right) }
    end
  end

  def self.hbal_min_nodes(h)
  end

  def self.hbal_max_height(n)
  end

  def self.hbal_tree_nodes(n, sym = :x)
  end

  def self.count_leaves(t)
    leaves(t).size
  end

  def self.leaves(t)
    root, left, right = t

    if root == :nil
      []
    elsif left == :nil && right == :nil
      [root]
    else
      leaves(left) + leaves(right)
    end
  end

  def self.internals(t)
    t.flatten.reject { |node| node == :nil } - leaves(t)
  end

  def self.at_level(t, n)
    root, left, right = t

    if n == 1
      root == :nil ? [] : [root]
    else
      at_level(left, n - 1) + at_level(right, n - 1)
    end
  end

  def self.complete_binary_tree(n)
  end

  def self.layout_binary_tree(t, method)
    case method
    when :inorder
    when :wide
    when :compact
    end
  end

  def self.tree_to_string(t)
    root, left, right = t

    if root == :nil
      ""
    elsif left == :nil && right == :nil
      "#{root}"
    else
      "#{root}(#{tree_to_string(left)},#{tree_to_string(right)})"
    end
  end

  def self.string_to_tree(s)
  end

  def self.tree_string(t_or_s)
    case t_or_s
    when Array
      tree_to_string t_or_s
    when String
      string_to_tree t_or_s
    end
  end

  def self.preorder(t)
    root, left, right = t

    if root == :nil
      ""
    elsif left == :nil && right == :nil
      "#{root}"
    else
      "#{root}" << preorder(left) << preorder(right)
    end
  end

  def self.inorder(t)
    root, left, right = t

    if root == :nil
      ""
    elsif left == :nil && right == :nil
      "#{root}"
    else
      inorder(left) << "#{root}" << inorder(right)
    end
  end

  def self.pre_in_tree(p, i)
  end

  def self.tree_to_dotstring(t)
    root, left, right = t

    if root == :nil
      "."
    elsif left == :nil && right == :nil
      "#{root}.."
    else
      "#{root}#{tree_to_dotstring(left)}#{tree_to_dotstring(right)}"
    end
  end

  def self.dotstring_to_tree(s)
  end

  def self.tree_dotstring(t_or_s)
    case t_or_s
    when Array
      tree_to_dotstring t_or_s
    when String
      dotstring_to_tree t_or_s
    end
  end
end
