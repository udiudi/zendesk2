class Zendesk2::Client::GetUserByExternalId < Zendesk2::Client::Request
  request_method :get
  request_params { |r| { "external_id" => r.external_id } }
  request_path   { |_| "/users/search.json" }

  def external_id
    params.fetch("external_id")
  end

  def mock
    results = self.data[:users].select { |k,v| v["external_id"].to_s.downcase == external_id.to_s.downcase }.values

    mock_response("users" => results)
  end
end
