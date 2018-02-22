require 'rails_helper'

RSpec.describe CsvUploadService do
  context ".valid_file" do
    it "fails on no file upload" do
      file = ''
      expect(CsvUploadService.valid_file?(file)).to eq(false)
    end

    it "fails on wrong file type" do
      file = ActionDispatch::Http::UploadedFile.new(
        tempfile: Tempfile.new,
        filename: 'restart.txt'
      )
      expect(CsvUploadService.valid_file?(file)).to eq(false)
    end

    it "success on csv file" do
      file = ActionDispatch::Http::UploadedFile.new(
        tempfile: Tempfile.new,
        filename: 'sample.csv'
      )
      expect(CsvUploadService.valid_file?(file)).to eq(true)
    end
  end
end
