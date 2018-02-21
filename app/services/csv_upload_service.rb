module CsvUploadService
  def self.valid_file? file
    # don't know why always get Content-Type: application/octet-stream
    # file.present? && file.content_type == 'text/csv'
    file.present? && file.original_filename.split('.').last == 'csv'
  end

  def self.save_file(temp)
    name = "csv_file_#{DateTime.now.to_i}.csv"
    FileUtils.cp(temp.path, "#{Rails.root}/tmp/#{name}")
    name
  end
end
