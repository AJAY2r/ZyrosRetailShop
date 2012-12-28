class InventoryCatalog

  # Do not apply percentage base discount for these categories.
  def self.no_percentage_discount(category)
     ["groceries"].include?(category) ?  true : false
  end

  #Some sample goods
  def self.get_goods_list
    {"electronics" => {"LCD" => 100, "home theater " => 45, "light" => 7}, "groceries" => {"milk" => 2, "bread" => 3, "sugar" => 5}, "furniture" => {"chair" => 10, "tabel" => 23, "beans-bag" => 14}, "dressing" => {"belt" => 3, "Jacket" => 16}}
  end
  
end
