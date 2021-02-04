# class TranscodeAudioJob < ApplicationJob
#   queue_as :default
#
#   def perform(case_document)
#     case_document.document.download
#     img = MiniMagick::Image.read(case_document.document.download)
#     img = img.format(case_document.document_type)
#     case_document.document.attach(
#       io: File.open(img.path),
#       filename: case_document.title,
#       content_type: case_document.document_type,
#     )
#   end
# end

class TranscodeAudioJob < ApplicationJob
  include ActiveJob::Status
  queue_as :default

  def perform(case_document)
    status.update(finished: false)
    progress.total = 10

    case_document.document.blob.open(tmpdir: "/tmp/") do |file|
      dst = Tempfile.new([( Time.now.to_i + rand(1000)).to_s, '.wav' ])
      dst.binmode
      cmd = <<-end_command
        ffmpeg -i #{file.path} -y -acodec pcm_s16le -ar 16000 -ac 1 #{dst.path}
      end_command

      puts "Running command: #{cmd}"

      system(cmd)

      # 10.times do |i|
      #   progress.increment
      #   sleep (1)
      # end

      speech = Google::Cloud::Speech.speech
      audio_file = File.binread(dst.path)
      config     = { encoding:          :LINEAR16,
                     sample_rate_hertz: 16_000,
                     language_code:     "en-US" }
      audio      = { content: audio_file }
      operation = speech.long_running_recognize config: config, audio: audio
      puts "Voice to text operation started"
      
      operation.wait_until_done!
      raise operation.results.message if operation.error?
      results = operation.response.results
      alternatives = results.first.alternatives
      alternatives.each do |alternative|
        puts "Transcription: #{alternative.transcript}"
        case_document.update_attribute :transcoded_text, alternative.transcript
      end

      status.update(transcoded_text: case_document.transcoded_text)
      status.update(finished: true)
    end
  end
end
