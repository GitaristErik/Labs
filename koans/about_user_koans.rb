# frozen_string_literal: true

require File.expand_path("#{File.dirname(__FILE__)}/neo")

class AboutUserKoans < Neo::Koan
  def test_invariable_string
    s = "That's an example String"
    s2 = "THAT'S AN EXAMPLE STRING"
    s.upcase
    assert_equal false, s == s2
  end

  def test_equals_double
    a = 1.2392
    b = 1.2391
    d = a - b
    res = 0.0001
    e = 1e-4
    # assert_equal d, res
    assert_equal d - res <= e, true
  end

  def test_sort_integer
    a1 = [1, 5, 2, 4, 3]
    # assert_equal __, a1.sort
    assert_equal [1, 2, 3, 4, 5], a1.sort
    a1.sort! { |a, b| b <=> a }
    # assert_equal __, a1
    assert_equal [5, 4, 3, 2, 1], a1
    a1.sort! { |a, b| a % 2 != 0 ? a <=> b : b <=> a }
    assert_equal [4, 2, 1, 3, 5], a1
  end

  def test_sort_alphabet
    s = %w[b c a d e]
    assert_equal %w[a b c d e], s.sort
    assert_equal %w[e d c b a], s.sort { |a, b| b <=> a }
    s.sort! { |a, b| a <= 'c' ? a <=> b : b <=> a }
    assert_equal %w[a b c e d], s
  end

  def test_created_time
    t = Time.new 2021, 3, 22, 21
    assert_equal true, t.monday?
    assert_equal false, t.tuesday?
    assert_equal false, t.wednesday?
    assert_equal false, t.thursday?
    assert_equal false, t.friday?
    assert_equal 2021, t.year
    assert_equal 22, t.day
    assert_equal true, t.min.is_a?(Integer)
  end

  def test_time_formatting
    time = Time.new 2021, 3, 22, 21
    assert_equal '22/03/2021', time.strftime('%d/%m/%Y')
    assert_equal '21:00', time.strftime('%k:%M')
    assert_equal '09:00 PM', time.strftime('%I:%M %p')
    assert_equal 'Today is Monday', time.strftime('Today is %A')
    assert_equal '22 of March, 2021', time.strftime('%d of %B, %Y')
  end

  def test_time_logic
    t1 = Time.new 2021, 3, 22, 21
    t2 = Time.new 2021, 3, 22, 23
    t1 += 10
    assert_equal 10, t1.sec
    t1 += 2 * 24 * 3600
    assert_equal 24, t1.day
    t1 += t2.day * t2.month
    assert_equal 24, t1.day
  end

  def test_date_time_and_zone
    require 'date'
    d = DateTime.parse('22rd Mar 2021 14:05:06+03:00')
    assert_equal 14, d.hour
    assert_equal 5, d.min
    assert_equal 6, d.sec
    assert_equal Rational(1, 8), d.offset
    assert_equal '+03:00', d.zone
    d += Rational('1.5')
    assert_equal '2021-03-24T02:05:06+03:00', d.strftime
    d = d.new_offset('+09:00')
    assert_equal '08:05:06 AM', d.strftime('%I:%M:%S %p')
  end

  def test_lambda
    a = ['a', :b, 'c', :d, :e]
    l = ->(x) { x.is_a? Symbol }
    s = a.select(&l)
    assert_equal [:b, :d, :e], s
    a = [:w, 42, 't', 3, true, 19, 12.345]
    l = ->(x) { x.is_a? Integer }
    ints = a.select(&l)
    assert_equal [42, 3, 19], ints
  end

  def test_proc
    a = [23, 101, 7, 104, 11, 94, 100, 121, 101, 70, 44]
    p = proc { |x| x < 100 }
    a.select!(&p)
    assert_equal [23, 7, 11, 94, 70, 44], a
  end

  def test_begin_rescue_ensure
    begin
      s = 's before raise. '
      raise 'An error has occured'
      s += 's after raise. '
    rescue Exception => e
      s += 's in rescue. '
      assert_equal 'An error has occurred', e.message
    ensure
      s += 's in ensure. '
    end
    assert_equal "s before raise. s in rescue. s in ensure. ", s
  end
end
