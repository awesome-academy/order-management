module ApplicationHelper
  def full_title page_title = ""
    base_title = t(".title")
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def get_index_page page = "page", key
    (params[page].blank? ? 0 : (params[page].to_i - 1)) * Settings.number_in_page + key + Settings.start
  end

  def get_index key
    key + Settings.start
  end

  def number_to_vnd number
    "#{number_to_currency(number,unit: "",separator: ",",delimiter: ".")} #{Settings.unit}"
  end
end
