require 'spec_helper'

describe 'filtering the beach by skills', :js => true do
  let(:autodesk) {Project.create!(name: 'Autodesk', category: 'client')}
  let(:beach) {Project.create!(name: 'Beach', category: 'beach')}

  let(:rails) {Skill.create!(name: 'Rails')}
  let(:javascript) {Skill.create!(name: 'Javascript')}
  let(:surface) {Skill.create!(name: 'Microsoft Surface')}

  let(:dom) {Rep.create!(name: 'Dominick', skills: [rails, javascript])}
  let(:kate) {Rep.create!(name: 'Kate')}
  let(:molly) {Rep.create!(name: 'Molly')}
  let(:this_week) {Date.today().cweek}

  let(:beach_week_views) {
    0.upto(3).map {|i| find('.beach-show .week-' + (this_week + i).to_s + ' ul.people')}
  }
  let(:project_week_views) {
    0.upto(3).map {|i| find('.project-show .week-' + (this_week + i).to_s + ' ul.people')}
  }
  let(:first_project_week_selector) {'.project-show .week-' + this_week.to_s + ' ul.people'}
  let(:first_beach_week_selector) {'.beach-show .week-' + this_week.to_s + ' ul.people'}

  before(:each) do
    @beach_weeks = []
    @beach_weeks << ProjectWeek.create!(project_id: beach.id, week_number: this_week, year: 2014, people: [dom, molly])
    @beach_weeks << ProjectWeek.create!(project_id: beach.id, week_number: this_week + 1, year: 2014, people: [dom, molly])
    @beach_weeks << ProjectWeek.create!(project_id: beach.id, week_number: this_week + 2, year: 2014, people: [dom, molly])
    @beach_weeks << ProjectWeek.create!(project_id: beach.id, week_number: this_week + 3, year: 2014, people: [dom, molly])

    @project_weeks = []
    @project_weeks << ProjectWeek.create!(project_id: autodesk.id, week_number: this_week, year: 2014, people: [kate])
    @project_weeks << ProjectWeek.create!(project_id: autodesk.id, week_number: this_week + 1, year: 2014, people: [kate])
    @project_weeks << ProjectWeek.create!(project_id: autodesk.id, week_number: this_week + 2, year: 2014, people: [kate])
    @project_weeks << ProjectWeek.create!(project_id: autodesk.id, week_number: this_week + 3, year: 2014, people: [kate])
  end

  context 'when you first load the page' do
    before do
      visit '/'
    end

    it 'should have no filter' do
      0.upto(3) do |i|
        beach_week_views[i].should have_content 'Dominick'
        beach_week_views[i].should have_content 'Molly'
        project_week_views[i].should have_content 'Kate'
      end
    end

    it 'should not show the clear filter text' do
      page.find('.beach-show').should_not have_selector('a.clear')
    end

  end

  context 'when you select Rails' do
    before do
      visit '/'
      page.find('.beach-show .dropdown button').click
      page.find('.beach-show .dropdown a[data-tag="Rails"]').click
    end

    it 'should filter the beach (but not project) by that tag' do
      0.upto(3) do |i|
        beach_week_views[i].all('.bill').count.should eq(1)
        beach_week_views[i].should have_content 'Dominick'
        project_week_views[i].should have_content 'Kate'
      end
    end

    it 'should show the clear filter text' do
      page.find('.beach-show a.clear').text.should eq('clear filter')
    end

    describe 'when you click the clear filter text' do
      before do
        page.find('.beach-show a.clear').click
      end

      it 'should show all the people' do
        0.upto(3) do |i|
          beach_week_views[i].should have_content 'Dominick'
          beach_week_views[i].should have_content 'Molly'
          project_week_views[i].should have_content 'Kate'
        end
      end

      it 'should not show the clear filter text' do
        page.find('.beach-show').should_not have_selector('a.clear')
      end
    end

    describe 'when you drag someone off the beach' do
      before do
        source_person = '.beach-show .week-' + this_week.to_s + ' ul.people li.bill[data-id="' + dom.id.to_s + '"]'
        drag_drop(source_person, first_project_week_selector)
      end

      it 'should move the bill off the beach' do
        beach_week_views[0].should have_content ''
        project_week_views[0].should have_content 'Dominick'
      end

      it 'leaves the filter in place' do
        page.find('.beach-show .dropdown button').text.should eq('Rails')
      end
    end

    describe 'when you drop someone onto the beach without that tag' do
      before do
        source_person = '.project-show .week-' + this_week.to_s + ' ul.people li.bill[data-id="' + kate.id.to_s + '"]'
        drag_drop(source_person, first_beach_week_selector)
      end

      it 'they wont show up while the filter is in place' do
        beach_week_views[0].should have_content ''
      end

      it 'leaves the filter in place' do
        page.find('.beach-show .dropdown button').text.should eq('Rails')
      end

      describe 'when you clear the filter' do
        before do
          page.find('.beach-show a.clear').click
        end

        it 'shows the bill you moved' do
          beach_week_views[0].should have_content 'Kate'
        end
      end
    end
  end
end
