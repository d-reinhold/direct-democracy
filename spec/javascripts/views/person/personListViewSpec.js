describe("app.Views.PersonList", function() {
  var personListView;

  var devJordi = {"id":356092,"name":"Jordi Noguera","primary_job":"Developer","created_at":"2014-02-24T07:46:36.574Z","updated_at":"2014-02-24T07:46:36.574Z","employment_status":null,"skill_ids":[1,2,3],"skill_names":["Rails","Javascript","iOS"],"is_anchor?":false};
  var pmAdam = {"id":357320,"name":"Adam Oliver","primary_job":"PM","created_at":"2014-02-24T07:46:36.604Z","updated_at":"2014-02-24T07:46:36.604Z","employment_status":null,"skill_ids":[],"skill_names":[],"is_anchor?":false};
  var devSara =  {"id":357217,"name":"Sara Tansey","primary_job":"Developer","created_at":"2014-02-24T07:46:36.611Z","updated_at":"2014-02-24T07:46:36.611Z","employment_status":null,"skill_ids":[5],"skill_names":["Java"],"is_anchor?":false};
  var people = new app.Collections.Person([devJordi, pmAdam, devSara]);

  var project = new app.Models.Project({id: 304503, name: 'Test Project', project_weeks: new app.Collections.ProjectWeek()});

  var projectWeek = new app.Models.ProjectWeek({
  	project_id: 304503,
  	dev_target: 4,
  	pm_target: 1,
  	design_target: 0,
  	week_number: 9,
  	year: 2014,
  	allocations: new Backbone.Collection([{'person_id':devJordi.id}, {'person_id':pmAdam.id}])
  });

  beforeEach(function() {
    personListView = new app.Views.PersonList({
      projectWeek: projectWeek,
      people: people,
      project: project,
      date: moment('2014-02-25', 'YYYY-MM-DD')
    });
  });

  describe("rendering", function() {
    beforeEach(function() {
      personListView.render();
    });

    it("should include the names of the people allocated", function() {
      expect(personListView.$el.text()).toContain(devJordi.name);
      expect(personListView.$el.text()).toContain(pmAdam.name);
      expect(personListView.$el.text()).not.toContain(devSara.name);
    });

    it("should include the correct number of needed developers", function() {
      expect(personListView.$el.find('.needs-bill.dev').length).toEqual(3);
    });

    it("should include the correct number of needed pms", function() {
      expect(personListView.$el.find('.needs-bill.pm').length).toEqual(0);
    });

    it("should include the correct number of needed designers", function() {
      expect(personListView.$el.find('.needs-bill.pm').length).toEqual(0);
    });

    describe("when a bill is not taking any vacation that week", function() {
      it ("should not show any vacation indicator bars", function() {
        expect(personListView.$el.find('li[data-id="' + devJordi.id + '"] .vacation .gone').length).toEqual(0);
        expect(personListView.$el.find('li[data-id="' + pmAdam.id + '"] .vacation .gone').length).toEqual(0);
      });
    });

    describe("when a bill is taking vacation that week on tuesday and friday", function() {
      beforeEach(function() {
        people.get(devJordi.id).set("vacation_days", ["2014-02-25", "2014-02-28"]);
      });

      it ("should show vacation indicator bars for those days", function() {
        var jordiVacation = personListView.$el.find("li[data-id='" + devJordi.id + "'] .vacation");
        expect(jordiVacation.find(".gone").length).toEqual(2);
        expect($(jordiVacation.find(".status")[1]).hasClass('gone')).toBeTruthy();
        expect($(jordiVacation.find(".status")[4]).hasClass('gone')).toBeTruthy();
      });
    });
  });
});
