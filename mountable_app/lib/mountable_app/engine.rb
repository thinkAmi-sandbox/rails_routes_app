module MountableApp
  class Engine < ::Rails::Engine
    isolate_namespace MountableApp
  end
end
