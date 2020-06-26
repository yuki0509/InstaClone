class User < ApplicationRecord
  #sorceryで追加された
  authenticates_with_sorcery!

end
