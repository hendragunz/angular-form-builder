# encoding: utf-8

class AttachmentUploader < CarrierWave::Uploader::Base

  # attributes
  attr_accessor :question_id, :form_id

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/form_entries/#{mounted_as}/#{form_id}/#{question_id}/#{Time.zone.now.to_i}"
  end


  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png pdf docx doc odt xls rtf)
  end

end
