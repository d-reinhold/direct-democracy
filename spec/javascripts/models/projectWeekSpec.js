describe('app.Models.ProjectWeek', function() {
  var jordi, sara, kate, dom, brendan, projectWeek;

  beforeEach(function() {
    jordi = {"id":356092,"name":"Jordi Noguera","primary_job":"Developer"};
    sara =  {"id":357217,"name":"Sara Tansey","primary_job":"Developer"};
    dom =  {"id":356682, "name":"Dominick Reinhold", "primary_job":"Developer"};
    kate =  {"id":357194,"name":"Kate Odell","primary_job":"Developer"};
    brendan =  {"id":356731,"name":"Brendan Kao","primary_job":"PM"};
    app.db.people = new app.Collections.Person([jordi, sara, dom, kate, brendan])
  });


  describe('#parse', function() {
    beforeEach(function() {
      projectWeek = new app.Models.ProjectWeek({ allocations: [jordi.id, sara.id]}, {parse: true});
    });

    it("should transform its allocations into a Backbone Collection of bill ids", function() {
      expect(projectWeek.get('allocations') instanceof Backbone.Collection).toBeTruthy();
      expect(projectWeek.get('allocations').pluck('person_id')).toEqual([jordi.id, sara.id]);
    });
  });


  describe("#underAllocated", function() {
    describe("when the project week doesn't have enough developers", function() {
      beforeEach(function() {
        projectWeek = new app.Models.ProjectWeek({
          dev_target: 4,
          pm_target: 1,
          design_target: 0,
          allocations: [jordi.id, sara.id]
        }, {parse: true});
      });

      it("should return true", function() {
        expect(projectWeek.underAllocated()).toBeTruthy();
      });
    });


    describe("when the project week has enough developers, but no PM", function() {
      beforeEach(function() {
        projectWeek = new app.Models.ProjectWeek({
          dev_target: 4,
          pm_target: 1,
          design_target: 0,
          allocations: [jordi.id, sara.id, dom.id, kate.id]
        }, {parse: true});
      });

      it("should return true", function() {
        expect(projectWeek.underAllocated()).toBeTruthy();
      });
    });


    describe("when the project week is fully allocated", function() {
      beforeEach(function() {
        projectWeek = new app.Models.ProjectWeek({
          dev_target: 4,
          pm_target: 1,
          design_target: 0,
          allocations: [jordi.id, sara.id, dom.id, kate.id, brendan.id]
        }, {parse: true});
      });

      it("should return false", function() {
        expect(projectWeek.underAllocated()).toBeFalsy();
      });
    });
  });
});
