module Urbix
  class Engine < ::Rails::Engine
    initializer 'urbix.load_urbix' do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/vendor"
    end
  end
end
