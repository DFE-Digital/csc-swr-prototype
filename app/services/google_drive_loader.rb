require 'docx'

module Services
  class GoogleDriverLoader
    def initialize(message)
      @message = message
    end

    def self.files
      authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
        json_key_io: File.open('./key.json'),
        scope: 'https://www.googleapis.com/auth/drive https://www.googleapis.com/auth/spreadsheets')

      data = authorizer.fetch_access_token!
      access_key = data['access_token']

      drive = Google::Apis::DriveV3::DriveService.new
      drive.authorization = access_key

      files = drive.list_files.files.select{|a| a.as_json['mime_type'] != 'application/vnd.google-apps.folder'}
    end

    def self.content(file_id)
      authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
        json_key_io: File.open('./key.json'),
        scope: 'https://www.googleapis.com/auth/drive https://www.googleapis.com/auth/spreadsheets')

      data = authorizer.fetch_access_token!
      access_key = data['access_token']

      drive = Google::Apis::DriveV3::DriveService.new
      drive.authorization = access_key

      temp_file = Tempfile.create
      drive.export_file(file_id, "application/vnd.openxmlformats-officedocument.wordprocessingml.document", download_dest: temp_file.path)

      Docx::Document.open(temp_file).text
    rescue => e
      ''
    end
  end
end
