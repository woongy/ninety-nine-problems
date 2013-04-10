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

  def self.huffman(fs)
  end
end