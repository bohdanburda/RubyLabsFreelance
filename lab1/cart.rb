# Клас "Cart" представляє місце для зберігання авто та виконання операцій збереження даних.

require './item_container.rb'

class Cart
  # Додаємо методи, реалізовані у модулі ItemContainer.
  include ItemContainer

  # Ініціалізує новий екземпляр класу "Cart".
  # @param app [MainApplication] Посилання на головний додаток для отримання шляху збереження файлів.
  def initialize(app)
    @items = []
    @path = app.data_storage_path
  end

  # Зберігає вміст кошика до текстового файлу.
  # За допомогою конкатенації, складаємо шлях з назви та шляху в налаштуваннях (@path + filename).
  # @param filename [String] Ім'я файлу, до якого буде здійснено збереження.
  def save_to_file(filename)
    File.open(@path + filename, 'w') do |file|
      @items.each do |item|
        file.puts item.to_s
      end
    end
  end

  # Зберігає вміст кошика у форматі JSON до файлу.
  #
  # @param filename [String] Ім'я файлу, до якого буде здійснено збереження у JSON-форматі.
  def save_to_json(filename)
    data = @items.map { |item| item.to_h }
    File.open(@path + filename, 'w') do |file|
      file.puts JSON.generate(data)
    end
  end

  # Зберігає вміст кошика у форматі CSV до файлу.
  #
  # @param filename [String] Ім'я файлу, до якого буде здійснено збереження у CSV-форматі.
  def save_to_csv(filename)
    CSV.open(@path + filename, 'w') do |csv|
      csv << ['Model', 'Year', 'Characteristics', 'Price']
      @items.each do |item|
        csv << [item.name, item.year, item.characteristics, item.price]
      end
    end
  end
end
