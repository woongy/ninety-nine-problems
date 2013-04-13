module Logic

  def self.table(expression)
    [true, false].repeated_permutation(expression.arity).inject({}) do |table, values|
      table.merge({ values => expression[*values] })
    end
  end

  def self.gray(n)
    if n == 1
      %w(0 1)
    else
      gray(n-1).map { |g| '0' << g } + gray(n-1).reverse.map { |g| '1' << g }
    end
  end

  # Examples
  #
  #   huffman_build_tree({ a: 45, b: 13, c: 12, d: 16, e: 9, f: 5 })
  #   # => [:a, [[:c, :b], [[:f, :e], :d]]]
  def self.huffman_build_tree(fs)
    tree = fs.to_a.map { |f| f.reverse }.sort
    until tree.size == 1
      m = tree.shift
      n = tree.shift
      tree.unshift [m.first + n.first, [m.last, n.last]]
      tree.sort!
    end
    tree[0][1]
  end

  # Examples
  #
  #   huffman_assign_code([:a, [[:c, :b], [[:f, :e], :d]]])
  #   # => [:a, "0", :b, "101", :c, "001", :d, "111", :e, "1011", :f, "0011"]
  def self.huffman_assign_code(node, prefix = "")
    case node
    when Symbol
      [node, prefix]
    else
      [
        huffman_assign_code(node.first, prefix + "0"),
        huffman_assign_code(node.last, prefix + "1")
      ].sort.flatten
    end
  end

  # Examples
  #
  #   huffman({ a: 45, b: 13, c: 12, d: 16, e: 9, f: 5 })
  #   # => {:a=>"0", :b=>"101", :c=>"100", :d=>"111", :e=>"1101", :f=>"1100"}
  def self.huffman(fs)
    tree = huffman_build_tree(fs)
    codes = huffman_assign_code(tree)
    Hash[*codes]
  end
end
