require 'spec_helper'

describe 'over and underallocation of projects', :js => true do
  let(:autodesk) {Project.create!(name: "Autodesk", category: 'client')}
  let(:beach) {Project.create!(name: 'Beach', category: 'beach')}
  let(:dom) {Rep.create!(name: 'Dominick')}
  let(:kate) {Rep.create!(name: 'Kate')}
  let(:molly) {Rep.create!(name: 'Molly')}
  let(:this_week) {Date.today().cweek}

  let(:beach_selector) {'.beach-show td.week-' + this_week.to_s + ' ul.people'}
  let(:beach_week_view) {page.find(beach_selector)}
  let(:project_selector) {'.project-show td.week-' + this_week.to_s + ' ul.people'}
  let(:project_week_view) {page.find(project_selector)}

  before(:each) do
    @beach_weeks = []
    @beach_weeks << ProjectWeek.create!(project_id: beach.id, week_number: this_week, year: 2014)
    @beach_weeks << ProjectWeek.create!(project_id: beach.id, week_number: this_week + 1, year: 2014)
    @beach_weeks << ProjectWeek.create!(project_id: beach.id, week_number: this_week + 2, year: 2014)
    @beach_weeks << ProjectWeek.create!(project_id: beach.id, week_number: this_week + 3, year: 2014)

    @project_weeks = []
    @project_weeks << ProjectWeek.create!(project_id: autodesk.id, week_number: this_week, year: 2014, dev_target: 2, pm_target: 0, design_target: 0)
    @project_weeks << ProjectWeek.create!(project_id: autodesk.id, week_number: this_week + 1, year: 2014, dev_target: 2, pm_target: 0, design_target: 0)
    @project_weeks << ProjectWeek.create!(project_id: autodesk.id, week_number: this_week + 2, year: 2014, dev_target: 2, pm_target: 0, design_target: 0)
    @project_weeks << ProjectWeek.create!(project_id: autodesk.id, week_number: this_week + 3, year: 2014, dev_target: 2, pm_target: 0, design_target: 0)
  end

  describe 'when dragging a developer off the beach' do
    before(:each) do
      @beach_weeks.each do |week|
        week.people << dom
        week.people << molly
        week.save
      end
      visit '/'
      project_week_view.should have_content ''
      beach_week_view.should have_content 'Dominick'
      beach_week_view.should have_content 'Molly'
    end
    describe 'when the destination project needs two developers in the target week to become fully allocated for all weeks' do
      before(:each) do
        source_person = '.beach-show .week-' + this_week.to_s + ' ul.people li.bill[data-id="' + dom.id.to_s + '"]'
        drag_drop(source_person, project_selector)
      end

      it 'should leave the project underallocated indicator on in the sidebar' do
        sidebar_project = page.find('#project-' + autodesk.id.to_s)
        sidebar_project['class'].should include('underallocated')
      end

      it 'should leave the week header color red for this week' do
        project_week_header = page.first("td.week-#{this_week} .week-header")
        project_week_header['class'].should include('needs-people')
      end
    end

    describe 'when the destination project becomes fully allocated for all weeks' do
      before(:each) do
        source_person_1 = '.beach-show td.week-' + this_week.to_s + ' ul.people li.bill[data-id="' + dom.id.to_s + '"]'
        source_person_2 = '.beach-show td.week-' + this_week.to_s + ' ul.people li.bill[data-id="' + molly.id.to_s + '"]'
        drag_drop(source_person_1, project_selector)
        drag_drop(source_person_2, project_selector)
      end

      it 'should move both the developers to the project' do
        project_week_view.should have_content 'Dominick'
        project_week_view.should have_content 'Molly'
        beach_week_view.should have_content ''
      end

      it 'should remove the project underallocated indicator from the sidebar' do
        sidebar_project = page.find('#project-' + autodesk.id.to_s)
        sidebar_project['class'].should_not include('underallocated')
      end

      it 'should change the week header color to blue for this week' do
        project_week_header = page.first("td.week-#{this_week} .week-header")
        project_week_header['class'].should_not include('needs-people')
      end
    end
  end

  describe 'when dragging a developer off a project' do
    before(:each) do
      @project_weeks.each do |week|
        week.people << dom
        week.people << molly
        week.people << kate
        week.save
      end
      visit '/'
      project_week_view.should have_content 'Kate'
      project_week_view.should have_content 'Dominick'
      project_week_view.should have_content 'Molly'
      beach_week_view.should have_content ''
    end

    describe 'when the project was overallocated for that week' do
      before(:each) do
        source_person = '.project-show td.week-' + this_week.to_s + ' ul.people li.bill[data-id="' + dom.id.to_s + '"]'
        drag_drop(source_person, beach_selector)
      end

      it 'should move the developer to the beach for that week' do
        project_week_view.should_not have_content 'Dominick'
        beach_week_view.should have_content 'Dominick'
        project_week_view.should have_content 'Molly'
      end

      it 'should not show the project underallocated indicator in the sidebar' do
        sidebar_project = page.find('#project-' + autodesk.id.to_s)
        sidebar_project['class'].should_not include('underallocated')
      end

      it 'should leave the week header color blue for this week' do
        project_week_header = page.first("td.week-#{this_week} .week-header")
        project_week_header['class'].should_not include('needs-people')
      end
    end

    describe 'when the project becomes underallocated' do
      before(:each) do
        source_person_1 = '.project-show td.week-' + this_week.to_s + ' ul.people li.bill[data-id="' + dom.id.to_s + '"]'
        source_person_2 = '.project-show td.week-' + this_week.to_s + ' ul.people li.bill[data-id="' + molly.id.to_s + '"]'
        drag_drop(source_person_1, beach_selector)
        drag_drop(source_person_2, beach_selector)
      end

      it 'should move both developers to the beach' do
        project_week_view.should_not have_content 'Dominick'
        project_week_view.should_not have_content 'Molly'
        project_week_view.should have_content 'Kate'
        beach_week_view.should have_content 'Dominick'
        beach_week_view.should have_content 'Molly'
      end

      it 'should add the project underallocated indicator to the sidebar' do
        sidebar_project = page.find('#project-' + autodesk.id.to_s)
        sidebar_project['class'].should include('underallocated')
      end

      it 'should change the week header color to red for this week' do
        project_week_header = page.first("td.week-#{this_week} .week-header")
        project_week_header['class'].should include('needs-people')
      end
    end
  end
end
