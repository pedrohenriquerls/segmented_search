json.array!(@query_segments) do |query_segment|
  json.extract! query_segment, :id
  json.url query_segment_url(query_segment, format: :json)
end
