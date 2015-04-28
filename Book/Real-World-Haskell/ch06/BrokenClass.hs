import SimpleJSON
instance (JSON a) => JSON [(String, a)] where
  toJValue = undefined
  fromJValue = undefined
