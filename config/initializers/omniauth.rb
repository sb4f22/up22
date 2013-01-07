Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "219227611541996", "a1d98de4ad417eff81555ebd0818f886"
  provider :twitter, "A41TPssQF12P5eaOJjVbog", "AtjH17JlMTQzNC1f11kpD3yIrvdQOjICPqs62wcmk"
  provider :google, "841571294417.apps.googleusercontent.com", "MoABpMsLMq14yQKhvQgAwdFd"
end