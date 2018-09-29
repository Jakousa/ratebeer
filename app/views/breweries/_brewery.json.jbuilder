json.extract! brewery, :id, :name, :year
json.beers brewery.beers do |beer|
  json.name beer.name
  json.style beer.style.name
end
