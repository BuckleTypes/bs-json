type 'a encoder = 'a -> Js.Json.t

external null : Js.Json.t = "" [@@bs.val]
external string : string -> Js.Json.t = "%identity"
external float : float -> Js.Json.t = "%identity"
external int : int -> Js.Json.t = "%identity"
external boolean : Js.boolean -> Js.Json.t = "%identity" 
external dict : Js.Json.t Js_dict.t -> Js.Json.t = "%identity"

let nullable encode = function
  | None -> null
  | Some v -> encode v

let withDefault d encode = function
  | None -> d
  | Some v -> encode v

let bool b =
  b |> Js.Boolean.to_js_boolean
    |> boolean 

let object_ props: Js.Json.t =
  props |> Js.Dict.fromList
        |> dict

external array : Js.Json.t array -> Js.Json.t = "%identity"
let list encode l =
  l |> List.map encode
    |> Array.of_list
    |> array

let pair encodeA encodeB (a, b) = array [| encodeA a; encodeB b|]

external stringArray : string array -> Js.Json.t = "%identity"
external numberArray : float array -> Js.Json.t = "%identity"
external booleanArray : Js.boolean array -> Js.Json.t = "%identity"
