module M : Api.NPC.S = struct
  let name = "ninja"

  let kind = Api.Extension.Kind.NPC

  class npc =
    let base : Api.NPC.Class.t = new Api.NPC.Class.base in
    object
      inherit Api.NPC.Class.base
      val! mutable agility = Int32.add 4l base#agility
      val! mutable damage = Int32.add 4l base#damage
      val! mutable health = Int32.add 2l base#health
    end
end

include Api.NPC.Register (M)
