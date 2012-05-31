module Fangorn
  autoload :Protection, 'fangorn/protection'
end

# Initialization hook.
ActiveSupport.on_load(:active_record) { include Fangorn::Protection }

