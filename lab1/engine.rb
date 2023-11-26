module MyApplicationReznik
    require './zipper.rb'
    class Engine
      def run_application(app, my_app_instance)
        # Запуск паралельного розбору 3 сторінок
        parallel_parse(app)
  
        # Запуск архівації файлів з розширенням, яке вказано в file_ext
        archive_files(my_app_instance)
      end
  
      private
  
      def parallel_parse(app)
        base_url = 'https://auto.ria.com/uk/search/?indexName=auto,order_auto,newauto_search&country.import.usa.not=-1&price.currency=1&abroad.not=0&custom.not=-1'
        urls_to_parse = ["#{base_url}&page=#{1}&size=10&scrollToAuto=35465937",
                         "#{base_url}&page=#{2}&size=10&scrollToAuto=35465937",
                         "#{base_url}&page=#{3}&size=10&scrollToAuto=35465937"]
        threads = urls_to_parse.map do |url|
           # Створення об'єкту "Parser" для парсингу вказаної сторінки та передача налаштувань додатку (app).
           parser = MyApplicationReznik::Parser.new(url, app)
           
           Thread.new { 
           # Створення об'єкту "Cart" для зберігання та операцій з авто.
           cart = MyApplicationReznik::Cart.new(app)
           # Парсинг веб-сторінки. Створення масиву авто.
           cars = parser.parse_items
           # Додаємо авто до кошика.
           cars.each do |car|
           cart.add_item(car)
           end
           # Відображення всіх авто в кошику.
           cart.show_all_items
           }
        end
  
        threads.each(&:join) # Очікування завершення всіх потоків
      end
  
      def archive_files(my_app_instance)
        # Отримання всіх файлів з розширенням, яке вказано в file_ext
        files_to_archive = Dir.glob("**/*.#{my_app_instance.file_ext}")
        # Створення архіву
        zipper = MyApplicationReznik::Zipper.new
        zipper.create_archive(files_to_archive, 'output_archive.zip')
      end
    end
  end
  