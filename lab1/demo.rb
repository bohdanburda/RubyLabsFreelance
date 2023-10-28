# Цей файл містить скрипт, який виконує наступні дії:
# 1. Створює об'єкт головного додатку "MainApplication" для налаштувань шляху зберігання та фільтрації даних.
# 2. Задає URL-адресу веб-сторінки та створює об'єкт "Parser" для парсингу сторінки.
# 3. Створює об'єкт "Cart" для зберігання та операцій з авто.
# 4. Видобуває інформацію про авто з веб-сторінки та додає її до кошика.
# 5. Відображає всі товари в кошику та виконує пошук за заданим запитом.
# 6. Зберігає інформацію про товари в текстовому файлі, JSON-файлі та CSV-файлі.

# Підключення необхідних класів
require './Parser.rb'
require './main_application.rb'
require './cart.rb'

# Задання шляху для зберігання даних та налаштувань фільтрації.
data_storage_path = './files/'
filter_settings = '' # Тут можна задати назву авто для фільтрації при парсингу, наприклад, 'BMW X5'.

# Створення об'єкту "MainApplication" з вказаними налаштуваннями.
app = MainApplication.new(data_storage_path, filter_settings)

# Задання URL-адреси веб-сторінки для парсингу.
base_url = 'https://auto.ria.com/uk/search/?indexName=auto,order_auto,newauto_search&country.import.usa.not=-1&price.currency=1&abroad.not=0&custom.not=-1'
page_number = 1 # Задання номера сторінки для парсингу.
url = "#{base_url}&page=#{page_number}&size=10&scrollToAuto=35465937" # Складаємо посилання.

# Створення об'єкту "Parser" для парсингу вказаної сторінки та передача налаштувань додатку (app).
parser = Parser.new(url, app)

# Створення об'єкту "Cart" для зберігання та операцій з авто.
cart = Cart.new(app)

# Парсинг веб-сторінки. Створення масиву авто.
cars = parser.parse_items

# Додаємо авто до кошика.
cars.each do |car|
  cart.add_item(car)
end

# Відображення всіх авто в кошику.
cart.show_all_items
# Пошук авто в кошику за назвою
cart.search_item('Volkswagen')

# Збереження інформації про товари з кошика в текстовому файлі, JSON-файлі та CSV-файлі.
cart.save_to_file('test.txt')
cart.save_to_json('test.json')
cart.save_to_csv('test.csv')
