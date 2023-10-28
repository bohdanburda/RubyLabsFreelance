# "MainApplication" представляє головний клас із налаштуваннями для зберігання та фільтрації даних.

# Усі необхідні бібліотеки, які використовуються у програмі
require 'nokogiri'
require 'open-uri'
require 'json'
require 'csv'

class MainApplication
  # Поля класу, які дозволяють доступ до шляху зберігання даних та налаштувань фільтрації.
  attr_accessor :data_storage_path, :filter_settings

  # Ініціалізує новий екземпляр класу "MainApplication" із заданими налаштуваннями.
  #
  # @param data_storage_path [String] Шлях до каталогу для зберігання даних.
  # @param filter_settings [Hash] Налаштування фільтрації даних.
  def initialize(data_storage_path, filter_settings)
    @data_storage_path = data_storage_path
    @filter_settings = filter_settings
  end
end
