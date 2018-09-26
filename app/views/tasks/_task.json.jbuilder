json.id task.id
json.title task.title
json.created_at task.created_at
json.updated_at task.updated_at
json.tags task.tags.pluck(:title)
json.comments task.comments, :body, :created_at
