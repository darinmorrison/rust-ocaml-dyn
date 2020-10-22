module M : Api.PowerUp.S = struct
  let name = "rum"

  let kind = Api.Extension.Kind.PowerUp

  class power_up =
    object
      method agility_modifier = -2l
      method damage_modifier = 0l
      method health_modifier = 2l
    end
end

include Api.PowerUp.Register (M)
