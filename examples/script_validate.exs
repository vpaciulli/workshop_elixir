defmodule CheckValue do
  def more_less(b) do
	cond do
	   b>0 -> "Positivo"
	   b<0 -> "Negativo"
	   true -> "Zero" 
	end
  end
def check_value_in_line(x) when x>0, do: "Positivo"  
def check_value_in_line(x) when x<0, do: "Negativo"
def check_value_in_line(0), do: "Zero"
end
