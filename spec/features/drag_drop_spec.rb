require 'spec_helper'

describe 'dragging and dropping allocations', :js => true do
  let(:autodesk) {Project.create!(name: 'Autodesk', category: 'client')}
  let(:beach) {Project.create!(name: 'Beach', category: 'beach')}
  let(:dom) {Rep.create!(name: 'Dominick')}
  let(:this_week) {Date.today().cweek}

  let(:beach_week_selectors) { (0).upto(7).reduce({}) {|h, i| h[i] = '.beach-show .week-' + (this_week + i).to_s + ' ul.people'; h} }
  let(:project_week_selectors) { (0).upto(7).reduce({}) {|h, i| h[i] = '.project-show .week-' + (this_week + i).to_s + ' ul.people'; h} }


  before(:each) do
    @beach_weeks = []
    @project_weeks = []
    (0).upto(7) do |i|
      beach_week = ProjectWeek.create!(project_id: beach.id, week_number: this_week + i, year: 2014)
      beach_week.people << dom if i != 6
      beach_week.save
      @beach_weeks << beach_week
      project_week = ProjectWeek.create!(project_id: autodesk.id, week_number: this_week + i, year: 2014, dev_target: 2, pm_target: 0, design_target: 0)
      project_week.people << dom if i == 6
      project_week.save
      @project_weeks << project_week
    end
    visit '/'
  end

  describe 'when the drop is valid' do
    before(:each) do
      0.upto(3) do |i|
        page.find(project_week_selectors[i]).should have_content ''
        page.find(beach_week_selectors[i]).should have_content 'Dominick'
      end
      click_link 'Next 4 weeks'
      4.upto(7) do |i|
        if i == 6
          page.find(project_week_selectors[i]).should have_content 'Dominick'
          page.find(beach_week_selectors[i]).should have_content ''
        else
          page.find(project_week_selectors[i]).should have_content ''
          page.find(beach_week_selectors[i]).should have_content 'Dominick'
        end
      end
      click_link 'Last 4 weeks'

      source_person = '.beach-show .week-' + (this_week + 1).to_s + ' ul.people li.bill[data-id="' + dom.id.to_s + '"]'
      drag_drop(source_person, project_week_selectors[1])
    end

    it 'should move the developer to the project for all the consecutive weeks he/she was allocated to the beach after the target week' do
      page.find(project_week_selectors[0]).should_not have_content 'Dominick'
      page.find(beach_week_selectors[0]).should have_content 'Dominick'

      1.upto(3) do |i|
        page.find(project_week_selectors[i]).should have_content 'Dominick'
        page.find(beach_week_selectors[i]).should_not have_content 'Dominick'
      end
      click_link 'Next 4 weeks'

      4.upto(6) do |i|
        page.find(project_week_selectors[i]).should have_content 'Dominick'
        page.find(beach_week_selectors[i]).should_not have_content 'Dominick'
      end

      page.find(project_week_selectors[7]).should_not have_content 'Dominick'
      page.find(beach_week_selectors[7]).should have_content 'Dominick'
    end
  end

  describe 'when the drop is invalid' do
    it 'does not make changes when bill is dragged between different weeks' do
      source_person = '.beach-show .week-' + this_week.to_s + ' ul.people li.bill[data-id="' + dom.id.to_s + '"]'
      page.find(project_week_selectors[0]).should have_content ''
      page.find(project_week_selectors[1]).should have_content ''
      page.find(beach_week_selectors[0]).should have_content 'Dominick'

      drag_drop(source_person, project_week_selectors[1])

      page.find(project_week_selectors[0]).should have_content ''
      page.find(project_week_selectors[1]).should have_content ''
      page.find(beach_week_selectors[0]).should have_content 'Dominick'
    end
  end
end
