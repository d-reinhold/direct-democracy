describe("app.Views.BeachShow", function() {
  var beachView, people, devJordi;

  beforeEach(function(){
    var beach = new app.Models.Project({
      category: "beach",
      created_at: "2014-02-25T17:18:00.323Z",
      id: 12345,
      name: "Beach",
      skill_ids: [],
      updated_at: "2014-02-25T17:18:00.323Z"
    });

    var skills = new Backbone.Collection([{id: 1, name: 'Rails'}, {id: 2, name: 'Java'}, {id: 3, name: 'iOS'}]);

    devJordi = {"id":356092,"name":"Jordi Noguera","primary_job":"Developer","created_at":"2014-02-24T07:46:36.574Z","updated_at":"2014-02-24T07:46:36.574Z","employment_status":null,"skill_ids":[1,2,3],"skill_names":["Rails","Java","iOS"],"skills":skills,"is_anchor?":false};
    var pmAdam = {"id":357320,"name":"Adam Oliver","primary_job":"PM","created_at":"2014-02-24T07:46:36.604Z","updated_at":"2014-02-24T07:46:36.604Z","employment_status":null,"skill_ids":[],"skill_names":[],"skills":new Backbone.Collection(),"is_anchor?":false};
    var devSara =  {"id":357217,"name":"Sara Tansey","primary_job":"Developer","created_at":"2014-02-24T07:46:36.611Z","updated_at":"2014-02-24T07:46:36.611Z","employment_status":null,"skill_ids":[5],"skill_names":["Java"],"skills":new Backbone.Collection({id: 2, name:'Java'}),"is_anchor?":false};
    people = new app.Collections.Person([devJordi, pmAdam, devSara]);

    var projectWeeks = new app.Collections.ProjectWeek(beach.id, 9, 2014);
    projectWeeks.reset([new app.Models.ProjectWeek({
      project_id: 12345,
      dev_target: 0,
      pm_target: 0,
      design_target: 0,
      week_number: 9,
      year: 2014,
      allocations: new Backbone.Collection([{'person_id': devJordi.id}, {'person_id':pmAdam.id}, {'person_id':devSara.id}])
    })]);

    beachView = new app.Views.BeachShow({
      week: 9,
      project: beach,
      projectWeeks: projectWeeks,
      people: people,
      skills: skills
    });
  });


  describe('#filteredPeople', function(){
    it("should return a Backbone Collection", function() {
      expect(beachView.filteredPeople() instanceof Backbone.Collection).toBeTruthy();
    });

    describe('when there is no filtered tag', function(){
      it('should return all the people', function(){
        expect(beachView.filteredPeople()).toEqual(people);
      });
    });
    describe('when there is a filtered tag', function() {
      beforeEach(function() {
        beachView.filteredSkill = 'Rails';
      });
      it("should return only people with that tag", function() {
        expect(beachView.filteredPeople().length).toEqual(1);
        expect(beachView.filteredPeople().pluck('name')).toEqual([devJordi.name]);
      });
    });
  });
});
