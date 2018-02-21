Spree::Admin::ProductsController.class_eval do
  def import_csv_file
    file_input = params[:csv_file]
    if CsvUploadService.valid_file?(file_input)
      saved_file = CsvUploadService.save_file(file_input.tempfile)
      CsvUploadService::Importer.new(saved_file).perform
      flash[:success] = 'File uploaded sucessfully.'
    else
      flash[:error] = 'No file or invalid content-type.'
    end

    redirect_to admin_products_path
  end
end
