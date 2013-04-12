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
end