module MountableSecondApp
  class Engine < ::Rails::Engine
    isolate_namespace MountableSecondApp
  end
end
