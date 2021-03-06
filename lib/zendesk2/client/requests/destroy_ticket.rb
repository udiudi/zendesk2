class Zendesk2::Client::DestroyTicket < Zendesk2::Client::Request
  request_method :delete
  request_path { |r| "/tickets/#{r.ticket_id}.json" }

  def ticket_id
    @_ticket_id ||= params.fetch("ticket").fetch("id")
  end

  def mock
    self.delete!(:tickets, ticket_id)

    mock_response(nil)
  end
end
