module List

  def self.last(x)
    x.last
  end

  def self.last_but_one(x)
    x[-2]
  end

  def self.element_at(x, k)
    x[k-1]
  end

  def self.length(x)
    x.length
  end

  def self.reverse(x)
    x.reverse
  end

  def self.palindrome?(x)
    x == x.reverse
  end

  def self.flatten(x)
    x.flatten
  end

  def self.compress(x)
    x.chunk { |e| e }.map(&:first)
  end

  def self.pack(x)
    x.chunk { |e| e }.map(&:last)
  end

  def self.encode(x)
    pack(x).map { |e| [length(e), e.first] }
  end

  def self.encode_modified(x)
    encode(x).map { |e| e.first == 1 ? e.last : e }
  end

  def self.decode(x)
    x.flat_map { |e| e.respond_to?(:first) ? [e.last] * e.first : e }
  end

  def self.encode_direct(x)
    last_seen, run_length, encoded = nil, 0, []
    (x + [nil]).each do |e|
      if e == last_seen
        run_length += 1
      else
        encoded << [run_length, last_seen] unless last_seen.nil?
        last_seen, run_length = e, 1
      end
    end
    encoded.map { |e| e.first == 1 ? e.last : e }
  end

  def self.dupli(x, k = 2)
    x.flat_map { |e| [e] * k }
  end

  def self.drop(x, k)
    x.reject.with_index(1) { |e, i| i % k == 0 }
  end

  def self.split(x, k)
    [x[0, k], x[k..-1]]
  end

  def self.slice(x, i, k)
    x[i-1...k]
  end

  def self.rotate(x, k)
    x.rotate(k)
  end

  def self.remove_at(x, k)
    [x.delete_at(k-1), x]
  end

  def self.insert_at(x, k, e)
    x.insert(k-1, e)
  end

  def self.range(n, m)
    (n..m).to_a
  end

  def self.rnd_select(x, k)
    x.sample(k)
  end

  def self.rnd_permu(x)
    x.shuffle
  end

  def self.combination(x, k)
    x.combination(k).to_a
  end

  def self.group(x, gs)
    gs.map { |g| x.slice!(0, g) }
  end

  def self.lsort(x)
    x.sort_by.with_index { |e, i| [e.length, i] } # stable sort
  end

  def self.lfsort(x)
    x.sort_by.with_index { |e, i| [x.count { |f| f.length == e.length }, i] } # stable sort
  end
end