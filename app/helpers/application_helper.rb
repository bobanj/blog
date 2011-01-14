module ApplicationHelper
  def rot13(str)
    str.tr!("A-Za-z", "N-ZA-Mn-za-m")
  end
end
