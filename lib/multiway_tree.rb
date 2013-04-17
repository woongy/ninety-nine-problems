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
end
