case {1, 2, 3} do
   {4, 5, 6} ->
     "Aqui Nunca vai cair."
   {1, x, 3} ->
     "Aqui x bindará 2"
   _ ->
     "Qualquer outro valor cai aqui"
end

x = 1
case 10 do
   ^x -> "O que acontece aqui?"
   _  -> "qualquer coisa serve"
end

cond do
   2 + 2 == 5 ->
     "Cond assume qualquer coisa que não seja nil ou false como verdadeiro"
   2 * 2 == 3 ->
     "Isso aqui também não é verdade"
   true ->
     "Equivalente ao else, aqui sempre será verdade"
end

if true do
   "Verdade"
 end

 unless true do
   "Nunca serei mostrado"
 end
