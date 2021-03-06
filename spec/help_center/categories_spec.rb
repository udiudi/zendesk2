require 'spec_helper'

describe "help_center/categories" do
  let(:client)   { create_client }

  include_examples "zendesk#resource", {
    :collection    => lambda { client.help_center_categories },
    :create_params => lambda { { name: mock_uuid, locale: "en-us" } },
    :update_params => lambda { { name: mock_uuid } },
    :search        => false,
  }

  context "with a category, sections, and articles" do
    let!(:category) { client.help_center_categories.create!(name: mock_uuid, locale: "en-us") }
    let!(:section)  { category.sections.create!(name: mock_uuid, locale: "en-us") }
    let!(:articles) { 2.times.map { section.articles.create(title: mock_uuid, locale: "en-us") } }

    before {
      client.help_center_categories.create!(name: mock_uuid, locale: "en-us").
      sections.create!(name: mock_uuid, locale: "en-us").articles.create!(title: mock_uuid, locale: "en-us")
    }

    it "lists sections within a category" do
      expect(category.sections.all).to contain_exactly(section)
    end

    it "lists articles within a category" do
      expect(category.articles.all).to match_array(articles)
    end
  end
end
