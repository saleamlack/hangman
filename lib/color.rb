# frozen_string_literal: true

# provide methods to colorize strings,
# modify in some extent
class String
  def red
    "\e[31m#{self}\e[0m"
  end

  def yellow
    "\e[33m#{self}\e[0m"
  end

  def green
    "\e[32m#{self}\e[0m"
  end

  def win
    "\n\t\e[42m#{self}\e[0m\n\n"
  end

  def lose
    "\n\t\e[41m#{self}\e[0m\n\n"
  end
end
