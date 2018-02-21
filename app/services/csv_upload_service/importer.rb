require 'csv'

module CsvUploadService
  class Importer
    # attributes needed [name description price available_on slug stock_total category]

    def initialize(file)
      @path = "#{Rails.root}/tmp/#{file}"
    end

    def perform
      # this should be processed in background
      products = []
      CSV.open(@path, 'r', col_sep: ';', headers: true, header_converters: :symbol) do |csv|
        csv.each do |row|
          # converts csv row to header=>value hash, except first nil keys
          product = row.to_hash.except!(nil)
          products << fix_attributes!(product) if valid?(product)
        end
      end
      # save products array to db ...
    end

    private
    def valid?(product)
      [product[:name].present?, product[:price].present?, product[:category].present?].all?
    end

    def fix_attributes!(product)
      product[:available_on] = product.delete(:availability_date).to_date
      product[:price] = product[:price].gsub(',', '.')
      product
    end
  end
end
