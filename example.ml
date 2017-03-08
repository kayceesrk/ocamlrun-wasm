effect E : int 
effect F : int 

let main () = 
  try 
    print_endline "perform E";
    let v1 = perform E in
    print_endline "perform F";
    let v2 = perform F in
    v1 + v2
  with
  | effect E k -> 
      print_endline "handle E";
      continue k 1
  | effect F k ->
      print_endline "handle F";
      continue k 2

let result = main ()
let _ = Printf.printf "main returned: %d\n%!" result
