class Zendesk2::Client::UpdateForum < Zendesk2::Client::Request
  request_method :put
  request_path { |r| "/forums/#{r.forum_id}.json" }
  request_body { |r| { "forum" => r.forum_params } }

  def forum_params
    Cistern::Hash.slice(params.fetch("forum"), *Zendesk2::Client::CreateForum.accepted_attributes)
  end

  def forum_id
    params.fetch("forum").fetch("id")
  end

  def mock
    mock_response(
      "forum" => find!(:forums, forum_id).merge!(forum_params),
    )
  end
end
