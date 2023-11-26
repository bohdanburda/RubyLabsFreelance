# Клас "Cart" представляє місце для зберігання авто та виконання операцій збереження даних.

module MyApplicationReznik

require './item_container.rb'

class Cart
  
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

  # Зберігає вміст кошика у форматі YAML до файлу.
  #
  # @param filename [String] Ім'я файлу, до якого буде здійснено збереження у YAML-форматі.
  def save_to_yml(filename)
    File.open(@path + filename, 'w') do |file|
      data_to_save = {
        'items' => @items.map do |item|
          {
            'Model' => item.name,
            'Year' => item.year,
            'Characteristics' => item.characteristics,
            'Price' => item.price
          }
        end
      }
      file.puts data_to_save.to_yaml
    end
  end
end


end

