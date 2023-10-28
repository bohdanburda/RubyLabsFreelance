# Клас "Item" представляє авто з параметрами: назва, рік, характеристики та ціна.

class Item
    # Поля класу.
    attr_accessor :name, :year, :characteristics, :price
  
    # Ініціалізує нове авто із заданими параметрами.
    #
    # @param name [String] Назва авто.
    # @param year [Integer] Рік виробництва авто.
    # @param characteristics [String] Характеристики авто.
    # @param price [Float] Ціна авто.
    def initialize(name, year, characteristics, price)
      @name = name
      @year = year
      @characteristics = characteristics
      @price = price
    end
  
    # Виводить інформацію про авто, у форматі переданого блоку, або за замовчуванням.
    #
    # @yield [self] Блок для обробки інформації про авто.
    def info(&block)
      if block_given?
        block.call(self)
      else
        puts to_s
      end
    end
  
    # Повертає рядок, що містить інформацію про авто.
    #
    # @return [String] Рядок інформації про авто.
    def to_s
      "Name: #{@name}, Year: #{@year}, Characteristics: #{@characteristics}, Price: $#{@price}"
    end
  
    # Повертає хеш, що містить інформацію про авто у форматі пар ключ-значення.
    #
    # @return [Hash] Хеш інформації про авто.
    def to_h
      {
        name: @name,
        year: @year,
        characteristics: @characteristics,
        price: @price
      }
    end
  end
  