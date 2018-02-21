defmodule Anagrams do 
	
	def test do 	  
	  List.foldr(read_file("wordlist.txt"), %{}, &add_to_map/2) 
	  |> Map.values() 
	  |> Enum.filter(fn (list) -> (length(list) > 1) end)
	  |> Enum.sort(fn (a, b) -> length(a) > length(b) end)
	  |> List.first
	end

	def read_file(file) do
		if File.exists?(file) do
      	  File.read!(file) |> String.split("\n") |> Enum.map(&clean_word/1)
      	end
    end

    def clean_word(word) do
    	String.replace(word, "'", "") |> String.downcase()
    end

    def add_to_map(word, map) do
      key = String.codepoints(word) |> Enum.sort() |> Enum.join("")
      Map.update(map, key, [word], fn (list) -> list ++ [word] end)      
    end

end