require 'spec_helper'

describe 'changing resource targets for projectWeeks', :js => true do
  let(:this_week) { Date.today().cweek }
  let(:autodesk) { Project.create!(name: "Autodesk", category: 'client') }
  let(:beach) { Project.create!(name: 'Beach', category: 'beach') }
  let(:dom) { Rep.create!(name: 'Dominick') }
  let(:kate) { Rep.create!(name: 'Kate') }
  let(:molly) { Rep.create!(name: 'Molly') }
  let(:beach_week_selectors) { (0).upto(7).reduce({}) { |h, i| h[i] = '.beach-show .week-' + (this_week + i).to_s + ' ul.people'; h } }
  let(:project_week_selectors) { (0).upto(7).reduce({}) { |h, i| h[i] = '.project-show .week-' + (this_week + i).to_s + ' ul.people'; h } }

  before(:each) do
    @beach_weeks = []
    @project_weeks = []
    (0).upto(2) do |i|
      beach_week = ProjectWeek.create!(project_id: beach.id, week_number: this_week + i, year: 2014)
      beach_week.people << molly
      beach_week.save
      @beach_weeks << beach_week
      project_week = ProjectWeek.create!(project_id: autodesk.id, week_number: this_week + i, year: 2014, dev_target: 2, pm_target: 0, design_target: 0)
      project_week.people << dom
      project_week.people << kate
      project_week.save
      @project_weeks << project_week
    end
    (3).upto(7) do |i|
      beach_week = ProjectWeek.create!(project_id: beach.id, week_number: this_week + i, year: 2014)
      beach_week.people << molly
      beach_week.people << dom
      beach_week.save
      @beach_weeks << beach_week
      project_week = ProjectWeek.create!(project_id: autodesk.id, week_number: this_week + i, year: 2014, dev_target: 2, pm_target: 0, design_target: 0)
      project_week.people << kate
      project_week.save
      @project_weeks << project_week
      autodesk.under_allocated_for_week_number[this_week + i] = true
      autodesk.save!
    end
    visit '/'
  end

  describe 'when a project needs another developer for this week to become fully allocated' do
    before(:each) do
      page.find(".project-show .week-#{this_week + 3} ul.people").should have_selector('li', 'needs-people')
      page.find('#project-' + autodesk.id.to_s)['class'].should include('underallocated')
      page.find(".project-show .week-#{this_week + 3} .week-header")['class'].should include('needs-people')
      page.find('.project-show .week-' + (this_week + 3).to_s + ' a.open-edit-modal').click
      within(:css, '.modal-content') do
        fill_in 'Developer Target', with: '1'
        click_button 'Save'
      end
      sleep 1
    end

    it 'should remove the needs-bill cell from the week' do
      page.find('.project-show .week-' + (this_week + 3).to_s).should have_no_selector 'li.needs-people'
    end

    it 'should remove the project underallocated indicator from the sidebar' do
      page.find('#project-' + autodesk.id.to_s)['class'].should_not include('underallocated')
    end

    it 'should change the week header color to blue for this week' do
      page.first(".project-show .week-#{this_week + 3} .week-header")['class'].should_not include('needs-people')
    end
  end

  describe 'when the "apply to all future weeks" box is checked' do
    before(:each) do
      click_link 'Next 4 weeks'
      page.find(".project-show .week-#{this_week + 6} ul.people").should have_selector('li', 'needs-people')
      page.find(".project-show .week-#{this_week + 6} .week-header")['class'].should include('needs-people')
      click_link 'Last 4 weeks'

      page.find('.project-show .week-' + (this_week + 3).to_s + ' a.open-edit-modal').click
      within(:css, '.modal-content') do
        fill_in 'Developer Target', with: '1'
        check 'Apply to all'
        click_button 'Save'
      end
      click_link 'Next 4 weeks'
    end

    it 'should remove the needs-bill cell from the week' do
      page.find('.project-show .week-' + (this_week + 6).to_s).should have_no_selector 'li.needs-people'
    end

    it 'should change the week header color to blue for this week' do
      page.find(".project-show .week-#{this_week + 6} .week-header")['class'].should_not include('needs-people')
    end
  end
end
