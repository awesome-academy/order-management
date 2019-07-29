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
    params[page].to_i * Settings.number_in_page + key + Settings.start
  end

  def get_index key
    key + Settings.start
  end
end
