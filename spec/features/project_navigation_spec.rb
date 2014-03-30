require 'spec_helper'

describe "project navigation", :js => true do
  before :each do
    Project.create!(name: "Humana", category: 'client')
    Project.create!(name: "Autodesk", category: 'client')
    Project.create!(name: "I Love BOSH", category: 'cloud foundry')
    Project.create!(name: 'Beach', category: 'beach')
    visit '/'
  end

  it "moves between projects in the same category" do
    active_project_title = page.find('hgroup h2').text
    selected_sidebar_item = page.find('ul.projects li.selected').text
    active_project_title.should eql('Autodesk')
    selected_sidebar_item.should eql('Autodesk')
    click_link 'Humana'
    sleep 0.5
    page.find('hgroup h2').text.should eql('Humana')
    page.find('ul.projects li.selected').text.should eql('Humana')
  end

  #xit "can expand and collapse categories" do
  #  #details feature of HTML 5 not yet implemented in Firefox...
  #  page.should_not have_content "I Love BOSH"
  #  click_on 'CLOUD FOUNDRY'
  #  page.should have_content "I Love BOSH"
  #  click_link 'I Love BOSH'
  #  page.should_not have_content "Autodesk"
  #end
end
