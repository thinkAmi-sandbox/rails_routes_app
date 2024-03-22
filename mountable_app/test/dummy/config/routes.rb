Rails.application.routes.draw do
  mount MountableApp::Engine => "/mountable_app"
end
