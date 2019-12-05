require_relative('models/star')
require_relative('models/movie')
require_relative('models/casting')

require('pry')

Casting.delete_all()
Movie.delete_all()
Star.delete_all()

star1 = Star.new({
  'first_name' => "Daniel",
  'second_name' => "Craig"
  })

star2 = Star.new({
  'first_name' => "Chris",
  'second_name' => "Evans"
  })

star3 = Star.new({
  'first_name' => "Margot",
  'second_name' => "Robbie"
  })

star1.save()
star2.save()
star3.save()


movie1 = Movie.new({
  'title' => "Knives Out",
  'genre' => "mystery"
  })

movie2 = Movie.new({
  'title' => "Once upon a time in Hollywood",
  'genre' => "action"
  })

movie1.save()
movie2.save()


casting1 = Casting.new({
  'movie_id' => movie1.id,
  'star_id' => star1.id,
  'fee' => 800
  })

casting2 = Casting.new({
  'movie_id' => movie1.id,
  'star_id' => star2.id,
  'fee' => 900
  })

casting3 = Casting.new({
  'movie_id' => movie2.id,
  'star_id' => star3.id,
  'fee' => 1800
  })

casting1.save()
casting2.save()
casting3.save()

binding.pry
nil
