require 'spec_helper'

describe 'navigating between blocks of weeks', :js => true do
  let(:autodesk) {Project.create!(name: 'Autodesk', category: 'client')}
  let(:beach) {Project.create!(name: 'Beach', category: 'beach')}
  let(:dom) {Rep.create!(name: 'Dominick')}
  let(:kate) {Rep.create!(name: 'Kate')}
  let(:molly) {Rep.create!(name: 'Molly')}
  let(:this_week) {Date.today().cweek}

  let(:beach_week_selectors) { (-2).upto(5).reduce({}) {|h, i| h[i] = '.beach-show .week-' + (this_week + i).to_s + ' ul.people'; h} }
  let(:project_week_selectors) { (-2).upto(5).reduce({}) {|h, i| h[i] = '.project-show .week-' + (this_week + i).to_s + ' ul.people'; h} }

  before(:each) do
    @beach_weeks = []
    @beach_weeks << ProjectWeek.create!(project_id: beach.id, week_number: this_week - 2, year: 2014, people: [dom])
    @beach_weeks << ProjectWeek.create!(project_id: beach.id, week_number: this_week - 1, year: 2014, people: [dom, molly])
    @beach_weeks << ProjectWeek.create!(project_id: beach.id, week_number: this_week, year: 2014, people: [dom, molly])
    @beach_weeks << ProjectWeek.create!(project_id: beach.id, week_number: this_week + 1, year: 2014, people: [dom, molly])
    @beach_weeks << ProjectWeek.create!(project_id: beach.id, week_number: this_week + 2, year: 2014, people: [dom, molly])
    @beach_weeks << ProjectWeek.create!(project_id: beach.id, week_number: this_week + 3, year: 2014, people: [dom, molly])
    @beach_weeks << ProjectWeek.create!(project_id: beach.id, week_number: this_week + 4, year: 2014, people: [dom, molly])
    @beach_weeks << ProjectWeek.create!(project_id: beach.id, week_number: this_week + 5, year: 2014, people: [dom])

    @project_weeks = []
    @project_weeks << ProjectWeek.create!(project_id: autodesk.id, week_number: this_week - 2, year: 2014, dev_target: 2, pm_target: 0, design_target: 0, people: [kate, molly])
    @project_weeks << ProjectWeek.create!(project_id: autodesk.id, week_number: this_week - 1, year: 2014, dev_target: 2, pm_target: 0, design_target: 0, people: [kate])
    @project_weeks << ProjectWeek.create!(project_id: autodesk.id, week_number: this_week, year: 2014, dev_target: 2, pm_target: 0, design_target: 0, people: [kate])
    @project_weeks << ProjectWeek.create!(project_id: autodesk.id, week_number: this_week + 1, year: 2014, dev_target: 2, pm_target: 0, design_target: 0, people: [kate])
    @project_weeks << ProjectWeek.create!(project_id: autodesk.id, week_number: this_week + 2, year: 2014, dev_target: 2, pm_target: 0, design_target: 0, people: [kate])
    @project_weeks << ProjectWeek.create!(project_id: autodesk.id, week_number: this_week + 3, year: 2014, dev_target: 2, pm_target: 0, design_target: 0, people: [kate])
    @project_weeks << ProjectWeek.create!(project_id: autodesk.id, week_number: this_week + 4, year: 2014, dev_target: 2, pm_target: 0, design_target: 0, people: [kate])
    @project_weeks << ProjectWeek.create!(project_id: autodesk.id, week_number: this_week + 5, year: 2014, dev_target: 2, pm_target: 0, design_target: 0, people: [kate, molly])

    visit '/'

    0.upto(3) do |i|
      page.find(project_week_selectors[i]).should have_content 'Kate'
      page.find(beach_week_selectors[i]).should have_content 'Dominick'
      page.find(beach_week_selectors[i]).should have_content 'Molly'
      page.should have_content(Date.commercial(2014, this_week + i).monday.strftime('%b %-d'))
    end
  end

  describe 'moving forwards' do
    before(:each) do
      click_link 'Next 4 weeks'
    end

    it 'should redraw the project views with the correct people for the next weeks' do
      page.should have_no_selector project_week_selectors[0]
      page.should have_no_selector beach_week_selectors[0]

      page.find(project_week_selectors[4]).should have_content 'Kate'
      page.find(project_week_selectors[5]).should have_content 'Molly'
      page.find(project_week_selectors[5]).should have_content 'Kate'
      page.find(beach_week_selectors[4]).should have_content 'Molly'
      page.find(beach_week_selectors[4]).should have_content 'Dominick'
      page.find(beach_week_selectors[5]).should have_content 'Dominick'
    end

    it 'should redraw the dashboard header with the correct week labels' do
      page.should have_content Date.commercial(2014, this_week + 4).monday.strftime('%b %-d')
      page.should have_content Date.commercial(2014, this_week + 5).monday.strftime('%b %-d')
      page.should have_content Date.commercial(2014, this_week + 6).monday.strftime('%b %-d')
      page.should have_content Date.commercial(2014, this_week + 7).monday.strftime('%b %-d')
    end
  end

  describe 'moving backwards' do
    before(:each) do
      click_link 'Last 4 weeks'
    end

    it 'should redraw the project views with the correct people for the previous weeks' do
      page.should have_no_selector project_week_selectors[0]
      page.should have_no_selector beach_week_selectors[0]

      page.find(project_week_selectors[-2]).should have_content 'Molly'
      page.find(project_week_selectors[-2]).should have_content 'Kate'
      page.find(project_week_selectors[-1]).should have_content 'Kate'
      page.find(beach_week_selectors[-1]).should have_content 'Dominick'
      page.find(beach_week_selectors[-1]).should have_content 'Molly'
      page.find(beach_week_selectors[-2]).should have_content 'Dominick'
    end

    it 'should redraw the dashboard header with the correct week labels' do
      page.should have_content Date.commercial(2014, this_week - 4).monday.strftime('%b %-d')
      page.should have_content Date.commercial(2014, this_week - 3).monday.strftime('%b %-d')
      page.should have_content Date.commercial(2014, this_week - 2).monday.strftime('%b %-d')
      page.should have_content Date.commercial(2014, this_week - 1).monday.strftime('%b %-d')
    end
  end
end
