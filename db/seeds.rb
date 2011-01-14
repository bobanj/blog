unless User.first
  u = User.new( :name     => 'BobiYo',
                :initials => 'BJ',
                :email    => 'bobanj@gmail.com',
                :login    => ADMIN_USERNAME,
                :password => ADMIN_PASSWORD,
                :password_confirmation => ADMIN_PASSWORD)
  r = u.save
end