S3DirectUpload.config do |c|
  c.access_key_id = ENV['S3_KEY_ID']       # your access key id
  c.secret_access_key = ENV['S3_SECRET_KEY']   # your secret access key
  c.bucket = ENV['S3_BUCKET']              # your bucket name
#  c.region = nil             # region prefix of your bucket url (optional), eg. "s3-eu-west-1"
#  c.url = nil                # S3 API endpoint (optional), eg. "https://#{c.bucket}.s3.amazonaws.com/"
end