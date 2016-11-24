maria.on(window, 'load', function() {
  var model = new checkit.TodosModel();

  for (var i = 0; i < 2; i++) {
    var view = new checkit.TodosAppView(model);
    document.body.appendChild(view.build());
  }
});
