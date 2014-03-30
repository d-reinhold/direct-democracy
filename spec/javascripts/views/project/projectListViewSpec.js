describe("app.Views.ProjectList", function() {
  var projectListView, projects, allocations, autodesk, awesomeness;

  beforeEach(function() {
    allocations = new app.Models.Project({
      category: "internal",
      created_at: "2014-02-25T17:18:00.477Z",
      id: 303949,
      name: "Allocations",
      skill_ids: [1, 2],
      updated_at: "2014-02-25T17:18:00.477Z",
      under_allocated_for_week_number: {
        9: false,
        10: false,
        11: false,
        12: false
      }
    });

    autodesk = new app.Models.Project({
      category: "client",
      created_at: "2014-02-25T17:18:00.323Z",
      id: 304503,
      name: "Autodesk",
      skill_ids: [2, 5, 42],
      updated_at: "2014-02-25T17:18:00.323Z",
      under_allocated_for_week_number: {
        9: false,
        10: false,
        11: false,
        12: false
      }
    });

    awesomeness = new app.Models.Project({
      category: "client",
      created_at: "2014-02-25T17:18:00.345Z",
      id: 304346,
      name: "Awesomeness TV",
      skill_ids: [1, 2],
      updated_at: "2014-02-25T17:18:00.345Z",
      under_allocated_for_week_number: {
        9: false,
        10: false,
        11: false,
        12: false
      }
    });

    projects = new app.Collections.Project([allocations, autodesk, awesomeness]);

    projectListView = new app.Views.ProjectList({
      collection: projects,
      currentProjectId: allocations.id
    });
  });

  describe("#render", function() {
    beforeEach(function() {
      projectListView.render();
    });

    describe("it renders the correct html", function() {
      describe("categories", function() {
        it("should have the right number of categories", function() {
          expect(projectListView.$el.find('.category').length).toEqual(2);
        });

        it("should display category names and counts", function() {
          expect(projectListView.$el.find('.category').first().text()).toContain('client');
          expect(projectListView.$el.find('.category').first().text()).toContain('2');
        });


        it("should have only one open category", function() {
          expect(projectListView.$el.find('details[open]').length).toEqual(1);
        });

        it("should open the category of the current project", function() {
          expect(projectListView.$el.find('details[open]').text()).toContain(allocations.get('name'));
        });
      });

      describe("projects", function() {
        it("should render all the projects", function() {
          expect(projectListView.$el.find('ul.projects li').length).toEqual(3);
        });

        it("should highlight the current project", function() {
          expect(projectListView.$el.find('li#project-' + (projectListView.currentProjectId))[0].className).toContain('selected');
        });

        it("should highlight no other projects", function() {
          expect(projectListView.$el.find('.selected').length).toEqual(1);
        });
      });
    });
  });
});
