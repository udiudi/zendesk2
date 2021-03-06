class Zendesk2::Client::GetView < Zendesk2::Client::Request
  request_method :get
  request_path { |r| "/views/#{r.view_id}.json" }

  def view_id
    params.fetch("view").fetch("id")
  end

  def mock
    mock_response("view" => self.find!(:views, view_id))
  end
end
