Rails.application.routes.draw do
  mount MountableSecondApp::Engine => "/mountable_second_app"
end
