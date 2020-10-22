module M : Api.Weapon.S = struct
  let name = "musket"

  let kind = Api.Extension.Kind.Weapon

  class weapon =
    object
      method damage_modifier = 3l
    end
end

include Api.Weapon.Register (M)
