module ApplicationHelper
  def bg_helper(it)
    case it
    when 0
      "bg-red-500"
    when 1
      "bg-red-400"
    when 2
      "bg-orange-400"
    when 3
      "bg-yellow-400"
    when 4
      "bg-blue-500"
    when 5
      "bg-green-400"
    when 6
      "bg-green-500"
    when 7
      "bg-green-500"
    end
  end
end
