json.array!(@ratings) do |rating|
  json.partial!('rating', rating: rating)
end
