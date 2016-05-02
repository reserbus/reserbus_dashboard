require 'rest-client'

SCHEDULER.every '120s' do
  response = Dataclip::Api.items(ENV['RATING_COMMENTS_ID'])
  sample_row = response.sample

  send_event('rating_comments', { title: "Comentario de #{sample_row.fetch("line")}", text: sample_row.fetch("comment") })
end
