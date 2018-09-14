class HiringUpload < ApplicationRecord
  has_one_attached :csv_file

  def initialize(params = {})
    super
    csv_file.attach(params[:csv_file])
  end
end
