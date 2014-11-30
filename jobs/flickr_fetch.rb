require 'flickraw'

FlickRaw.api_key="YOUR_API_KEY"
FlickRaw.shared_secret="YOUR_SERCRET"

$flickrUsername = "username"

# image urls to retrieve, if the image size is not available, the next one is used and so on
# see https://www.flickr.com/services/api/misc.urls.html for details
$extensionFields = ['url_c','url_o']

def getPhotoUrl(photo)
  $extensionFields.each do |extField|
    return photo.send(extField) if photo.respond_to?(extField)
  end
  nil
end

def getPhotoUrlsFromPage(photosetPage)
  photosetPage.photo.map { |photo| getPhotoUrl(photo) }
end

def getPhotosPageFromSet(photosetId, page)
  extFieldsString = $extensionFields.join(',')
  flickr.photosets.getPhotos(:photoset_id => photosetId, :extras => extFieldsString, :per_page => 500, :page => page)
end

def getPhotosFromSet(photosetId)
  firstPage = getPhotosPageFromSet(photosetId, 1)
  photos = getPhotoUrlsFromPage(firstPage)
  (2 .. firstPage.pages).each do |pageNo|
    currPage = getPhotosPageFromSet(photosetId, pageNo)
    photos.concat(getPhotoUrlsFromPage(currPage))
  end
  photos
end

userId = flickr.people.findByUsername(:username => $flickrUsername).nsid
photosetPhotos = flickr.photosets.getList(:user_id => userId).map { |photoset| getPhotosFromSet(photoset.id) }.flat_map { |u| u }

# for debug
# photosetPhotos.each do |pp|
#  puts pp
# end

SCHEDULER.every '20s', first_in: 0 do |job|
  url = photosetPhotos.sample
  send_event('flickr', imageUrl: url)
end
