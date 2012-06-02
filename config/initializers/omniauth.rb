Rails.application.config.middleware.use OmniAuth::Builder do  
    provider :facebook, '322102001181888',  '0c6bd894ee63af7932f54e879b381c58'
    provider :twitter, 'tgcpAoCHiXlLsAakh0vzNA',  'U4bLWFvPQnpUhLzVpLQiA1l7L6ZF7Ksd75uHfx9Q'
end
