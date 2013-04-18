module Kernel
  def T(*args)
    args
  end
end

module MultiwayTree

  def self.forest?(f)
    if f.nil?
      false
    elsif f == []
      true
    else
      f.all? { |t| tree?(t) }
    end
  end

  def self.tree?(t)
    root, forest = t

    !root.nil? && forest?(forest)
  end

  def self.nnodes(t)
    root, forest = t

    forest.empty? ? 1 : forest.inject(1) { |n, t| n + nnodes(t) }
  end

  def self.tree_to_string(t)
    root, forest = t

    if forest.nil?
      "#{root}^"
    else
      "#{root}" << forest.map { |f| tree_to_string(f) }.join << "^"
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
end
