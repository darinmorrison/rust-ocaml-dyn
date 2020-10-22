module M : Api.Weapon.S = struct
  let name = "kitana"

  let kind = Api.Extension.Kind.Weapon

  class weapon =
    object
      method damage_modifier = 2l
    end
end

include Api.Weapon.Register (M)
