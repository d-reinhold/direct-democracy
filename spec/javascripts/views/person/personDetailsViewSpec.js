describe("app.Views.PersonDetails", function() {
  var jordi, sara, personDetailsView, weekNumber;


  beforeEach(function() {
    jordi = {"id":356092,"name":"Jordi Noguera","primary_job":"Developer","created_at":"2014-02-24T07:46:36.574Z","updated_at":"2014-02-24T07:46:36.574Z","employment_status":null,"skill_ids":[1,2,3],"skill_names":["Rails","Javascript","iOS"],"is_anchor?":false};
    sara =  {"id":357217,"name":"Sara Tansey","primary_job":"Developer","created_at":"2014-02-24T07:46:36.611Z","updated_at":"2014-02-24T07:46:36.611Z","employment_status":null,"skill_ids":[5],"skill_names":["Java"],"is_anchor?":false};

    var project = new app.Models.Project({id: 304503, name: 'Test Project', project_weeks: new app.Collections.ProjectWeek()});
    app.db.projects = new app.Collections.Project([project]);

    _(_.range(4, 10)).each(function(i) {
      if (i !== 7) {
        project.get('project_weeks').push(new app.Models.ProjectWeek({
          project_id: project.id,
          week_number: i,
          year: 2014,
          allocations: new Backbone.Collection([{'person_id':jordi.id}, {'person_id':sara.id}])
        }));
      }
    });
    spyOn(app.Views.PersonItem.prototype, 'listenTo');

    personDetailsView = new app.Views.PersonDetails({
      model: jordi,
      date: moment('03-03-2014', 'DD-MM-YYYY'),
      project: project
    });
  });


  describe("#totalWeeksOnProject", function() {
    it("should compute the number of weeks the bill has been on this project, including this week (but no future weeks)", function() {
      expect(personDetailsView.totalWeeksOnProject()).toEqual('5th week on Test Project');
    });
  });

  describe("#weeksInCurrentStint", function() {
    it("should compute the number of consecutive weeks the bill has been on this project, including this week (but no future weeks)", function() {
      expect(personDetailsView.weeksInCurrentStint()).toEqual('3rd week in current stint');
    });
  });

});
