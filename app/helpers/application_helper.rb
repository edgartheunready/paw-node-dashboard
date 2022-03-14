module ApplicationHelper
  def bg_helper(it)
    case it
    when 0
      "bg-red-500"
    when 1
      "bg-orange-500"
    when 2
      "bg-orange-500"
    when 3
      "bg-yellow-500"
    when 4
      "bg-green-500"
    when 5
      "bg-green-600"
    when 6
      "bg-blue-500"
    when 7
      "bg-blue-500"
    end
  end
end
