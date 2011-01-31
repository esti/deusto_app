module TweetsHelper
  def odd_or_even(number)
    number % 2 == 0 ? "even" : "odd"
  end
end
