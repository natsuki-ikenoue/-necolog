class ImageUploader < CarrierWave::Uploader::Base
# リサイズしたり画像形式を変更するのに必要
  include CarrierWave::RMagick

# アップローダーでどんな種類のものを受け取るか指定
  storage :file

# ファイルサイズに制限をつける
  def size_range
    1..5.megabytes
  end

# 画像の上限を640x480にする
  process :resize_to_fit=> [640, 480]

# 保存形式をJPGにする
  process :convert => 'jpg'

# jpg,jpeg,gif,pngしか受け付けない
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

# 拡張子が同じでないとGIFをJPGとかにコンバートできないので、ファイル名を変更
  def filename
    super.chomp(File.extname(super)) + '.jpg' if original_filename.present?
  end

# ファイル名を日付にすると編集時のデータ受け渡し等で不具合が出るため、ファイル名をランダムで一意にする
  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

protected
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end


# アップロードされたファイルを保存するディレクトリをデフォルトに設定する
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end
