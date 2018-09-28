# Basic attributes
json.id task.id
json.title task.title
json.created_at task.created_at
json.updated_at task.updated_at

# Related records
json.tags task.tags.pluck(:title)
json.comments task.comments do |comment|
  json.body_html comment.body_html
  # Ideally you'd parse this time stamp in JS, but that's a whole extra library
  json.created_at comment.created_at.to_s(:long)
end
