class Util
  
  # format source string 
  def self.format_string(source_str,size_type)
    begin
      formatted_str = source_str.ljust(Util.total_size[size_type])
    rescue
      formatted_str = source_str
    end
    return formatted_str
  end
  
  private
  
  def self.total_size
    {"category" => 16, "item" => 16, "price" => 9, "customer_type" => 17 ,"option" => 25,"category_invoice" => 35, "item_invoice" => 41, "price_invoice" => 12}
  end

end