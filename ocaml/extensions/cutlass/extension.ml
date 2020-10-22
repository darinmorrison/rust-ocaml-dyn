module M : Api.Weapon.S = struct
  let name = "cutlass"

  let kind = Api.Extension.Kind.Weapon

  class weapon =
    object
      method damage_modifier = 1l
    end
end

include Api.Weapon.Register (M)
