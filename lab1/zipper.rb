require 'zip'

module MyApplicationReznik
  class Zipper
    # Створює архів із заданими файлами та зберігає його за вказаним шляхом.
    #
    # @param files [Array<String>] Масив імен файлів, які слід включити до архіву.
    # @param output_path [String] Шлях, за яким слід зберегти створений архів.
    def create_archive(files, output_path)
      Zip::File.open(output_path, Zip::File::CREATE) do |zipfile|
        files.each do |file|
          zipfile.add(File.basename(file), file)
        end
      end
      puts "Archive created successfully at #{output_path}"
    rescue StandardError => e
      puts "Error creating the archive: #{e.message}"
    end
  end
end