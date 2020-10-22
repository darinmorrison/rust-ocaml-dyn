module M : Api.Weapon.S = struct
  let name = "shuriken"

  let kind = Api.Extension.Kind.Weapon

  class weapon =
    object
      method damage_modifier = 2l
    end
end

include Api.Weapon.Register (M)
