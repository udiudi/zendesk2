class Zendesk2::Client::CreateCategory < Zendesk2::Client::Request
  request_method :post
  request_path { |_| "/categories.json" }
  request_body { |r| {"category" => r.params["category"]} }

  def self.accepted_attributes
    %w[id name description position]
  end

  def mock
    identity = service.serial_id

    record = {
      "id"         => identity,
      "url"        => url_for("/categories/#{identity}.json"),
      "created_at" => Time.now.iso8601,
      "updated_at" => Time.now.iso8601,
    }.merge(Cistern::Hash.slice(params.fetch("category"), *self.class.accepted_attributes))

    service.data[:categories][identity] = record

    mock_response({"category" => record}, {status: 201})
  end
end
