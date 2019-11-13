let rec chop k l =
  if k = 0 then l else begin
    match l with
    | x::t -> chop (k-1) t
    | _ -> assert false
  end
;;

let stable_sort l fcomp =
  let rec rev_merge l1 l2 accu =
    match l1, l2 with
    | [], l2 -> List.rev_append l2 accu
    | l1, [] -> List.rev_append l1 accu
    | h1::t1, h2::t2 ->
       let compres = fcomp h1 h2 in
       if compres < 0
       then rev_merge t1 l2 (h1::accu)
       else rev_merge l1 t2 (h2::accu)
  in
  let rec rev_merge_rev l1 l2 accu =
    match l1, l2 with
    | [], l2 -> List.rev_append l2 accu
    | l1, [] -> List.rev_append l1 accu
    | h1::t1, h2::t2 ->
       let compres = fcomp h1 h2 in
        if compres > 0
        then rev_merge_rev t1 l2 (h1::accu)
        else rev_merge_rev l1 t2 (h2::accu)
  in
  let rec sort n l =
    match n, l with
    | 2, x1 :: x2 :: _ ->
       if x1 <= x2 then [x1; x2] else [x2; x1]
    | 3, x1 :: x2 :: x3 :: _ ->
       if x1 <= x2 then begin
         if x2 <= x3 then [x1; x2; x3]
         else if x1 <= x3 then [x1; x3; x2]
         else [x3; x1; x2]
       end else begin
         if x1 <= x3 then [x2; x1; x3]
         else if x2 <= x3 then [x2; x3; x1]
         else [x3; x2; x1]
       end
    | n, l ->
       let n1 = n asr 1 in
       let n2 = n - n1 in
       let l2 = chop n1 l in
       let s1 = rev_sort n1 l in
       let s2 = rev_sort n2 l2 in
       rev_merge_rev s1 s2 []
  and rev_sort n l =
    match n, l with
    | 2, x1 :: x2 :: _ ->
       if x1 > x2 then [x1; x2] else [x2; x1]
    | 3, x1 :: x2 :: x3 :: _ ->
       if x1 > x2 then begin
         if x2 > x3 then [x1; x2; x3]
         else if x1 > x3 then [x1; x3; x2]
         else [x3; x1; x2]
       end else begin
         if x1 > x3 then [x2; x1; x3]
         else if x2 > x3 then [x2; x3; x1]
         else [x3; x2; x1]
       end
    | n, l ->
       let n1 = n asr 1 in
       let n2 = n - n1 in
       let l2 = chop n1 l in
       let s1 = sort n1 l in
       let s2 = sort n2 l2 in
       rev_merge s1 s2 []
  in
  let len = List.length l in
  if len < 2 then l else sort len l
;;

stable_sort [4;2;5;3];;
stable_sort ["mauve";"bleu";"blanc";"carmin"];;
