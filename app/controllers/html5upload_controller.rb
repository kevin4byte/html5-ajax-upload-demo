require 'securerandom'

class Html5uploadController < ApplicationController

  def upload
  end

  def ajax_upload
    if params[:mime] then
      _, ext = params[:mime].split "/"
      random_name = SecureRandom.hex(24)
      tmp_dir = "#{Rails.root}/public/up"
      Dir.mkdir(tmp_dir) unless Dir.exists?(tmp_dir)
      f = Tempfile.open([random_name, ".#{ext}"], tmp_dir, :encoding => 'ascii-8bit') do |f|
        f.write(request.env['rack.input'].read)
        f
      end
      render :text => "/up/#{File.basename(f)}"
    end
  end
end
