# Модуль "ItemContainer" надає функціональність для керування колекцією авто.

module ItemContainer

    # Модуль "ClassMethods" містить методи класу, які можуть бути викликані на рівні класу, а не на рівні екземпляру.
    
    module ClassMethods
      # Метод для пошуку авто за назвою.
      #
      # @param query [String] Запит для пошуку авто.
      # @return [Array] Масив авто, які відповідають запиту.
      def search_item(query)
        puts "Searching for items with query: #{query}"
        results = @items.select do |item|
          item.name.downcase.include?(query.downcase)
        end
        puts results
      end
    end
  
    # Модуль "InstanceMethods" містить методи екземпляру, які можуть бути викликані на рівні конкретного екземпляру класу.

    module InstanceMethods
      # Метод для додавання авто до колекції.
      #
      # @param item [Object] Авто для додавання.
      def add_item(item)
        @items << item
        puts "Item added: #{item}"
      end
  
      # Метод для видалення авто з колекції.
      #
      # @param item [Object] Авто для видалення.
      def remove_item(item)
        @items.delete(item)
        puts "Item removed: #{item}"
      end
  
      # Метод для очищення колекції від усіх авто.
      def delete_items
        @items.clear
        puts "All items deleted."
      end
  
      # Обробник виклику методу, який перевіряє, чи існує метод "show_all_items".
      # Якщо так, він викликає його для відображення всіх товарів.
      #
      # @param method_name [Symbol] Ім'я викликаного методу.
      def method_missing(method_name, *args)
        if method_name.to_s == "show_all_items"
          show_all_items
        else
          # Викликає метод super, що призводить до виникнення виключення NoMethodError.
          super 
        end
      end
  
      # Метод для відображення всіх авто у колекції.
      def show_all_items
        puts "All Items:"
        @items.each { |item| puts item }
      end
    end
  
    # Метод "self.included" викликається, коли модуль "ItemContainer" включений до класу.
    # Він розширює методи класу та включає методи екземпляру.
  
    def self.included(class_instance)
      class_instance.include(ClassMethods)
      class_instance.include(InstanceMethods)
    end
  end
  