not_found do
  pass unless unhandled_not_found?
  json error_json("not_found", "Not Found")
end

def unhandled_not_found?
  response.body == ["<h1>Not Found</h1>"]
end

error do
  json error_json("internal_error", "Internal Server Error")
end
