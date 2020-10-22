module Extension = struct
  module Kind = struct
    type t = NPC | PowerUp | Weapon
  end

  module type S = sig
    val name : string

    val kind : Kind.t
  end

  let exts : (string, (module S)) Hashtbl.t = Hashtbl.create 0
end

module NPC = struct
  module Class = struct
    class type t =
      object
        val mutable agility : int32

        val mutable damage : int32

        val mutable health : int32

        method agility : int32

        method damage : int32

        method health : int32
      end

    class base : t =
      object
        val mutable agility = Random.int32 5l

        val mutable damage = Random.int32 5l

        val mutable health = Random.int32 5l

        method agility = agility

        method damage = damage

        method health = health
      end

    module type S = sig
      class npc : base
    end
  end

  module type S = sig
    include Extension.S

    include Class.S
  end

  let exts : (string, (module S)) Hashtbl.t = Hashtbl.create 0

  module Register (M : S) = struct
    let () =
      Hashtbl.add Extension.exts M.name (module M : Extension.S);
      Hashtbl.add exts M.name (module M : S);
      Printf.printf "npc :: registered: %s\n" M.name
  end
end

module PowerUp = struct
  module Class = struct
    class type t =
      object
        method agility_modifier : int32

        method damage_modifier : int32

        method health_modifier : int32
      end

    module type S = sig
      class power_up : t
    end
  end

  module type S = sig
    include Extension.S

    include Class.S
  end

  let exts : (string, (module S)) Hashtbl.t = Hashtbl.create 0

  module Register (M : S) = struct
    let () =
      Hashtbl.add Extension.exts M.name (module M : Extension.S);
      Hashtbl.add exts M.name (module M : S);
      Printf.printf "powerup :: registered: %s\n" M.name
  end
end

module Weapon = struct
  module Class = struct
    class type t =
      object
        method damage_modifier : int32
      end

    module type S = sig
      class weapon : t
    end
  end

  module type S = sig
    include Extension.S

    include Class.S
  end

  let exts : (string, (module S)) Hashtbl.t = Hashtbl.create 0

  module Register (M : S) = struct
    let () =
      Hashtbl.add Extension.exts M.name (module M : Extension.S);
      Hashtbl.add exts M.name (module M : S);
      Printf.printf "weapon :: registered: %s\n" M.name
  end
end
