module MyApplicationReznik

class InputReader
    def read(welcome_message: nil, process: nil, validator: nil, error_message: nil)
      puts welcome_message if welcome_message
  
      loop do
        print 'Введіть дані: '
        input = gets.chomp
  
        if validator.call(input)
          result = process.call(input)
          puts "Результат обробки: #{result}" if result
          break
        else
          puts error_message if error_message
        end
      end
    end
  end
  
end