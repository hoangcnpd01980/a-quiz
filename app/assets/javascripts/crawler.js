$(document).on('turbolinks:load', function() {

  $("#select-multiple").click(function() {
    if ($("input:checkbox").hasClass('d-none')) {
      $("input:checkbox").removeClass('d-none');
      $("#select-all").removeClass('d-none');
      $("#select-cancel").addClass('d-none');
      $("#destroy-multi").removeClass('d-none');
      $("#import-multi").removeClass('d-none');
    }
    else {
      $("input:checkbox").addClass('d-none');
      $("#select-all").addClass('d-none');
      $("#select-cancel").addClass('d-none');
      $("#destroy-multi").addClass('d-none');
      $("#import-multi").addClass('d-none');
    }
    return false;
  });

  $("#select-all").click(function() {
    $("input:checkbox").attr("checked", true);
    $("#select-all").addClass('d-none');
    $("#select-cancel").removeClass('d-none');
    return false;
  });

  $("#select-cancel").click(function() {
    $("input:checkbox").attr("checked", false);
    $("#select-all").removeClass('d-none');
    $("#select-cancel").addClass('d-none');
    return false;
  });

  $("#import-multi").click(function() {
    if (questions_checked().length == 0) {
      alert("No questions have been selected");
      return false;
    }
  });

  $("#submit-multi").click(function() {
    var category_id = $("#category-multi").val();
    if (category_id) {
      if (confirm("Are you sure you want to import?")) {
        $.ajax({
          type: "post",
          url: "/admin/crawlers",
          dataType: "script",
          data: { category: category_id, ids: questions_checked() }
        });
      }
    }
    else {
      alert("You must choose a category!");
    }
    return false;
  });

  $("#destroy-multi").click(function() {
    if (questions_checked().length) {
      if (confirm("Are you sure you want to delete?")) {
        $.ajax({
          type: "delete",
          url: "/admin/crawlers",
          dataType: "script",
          data: { ids: questions_checked() }
        });
      }
    }
    else {
      alert("No questions have been selected");
    }
    return false;
  });

  function questions_checked() {
    var checked = [];
    $("input[name='questions[]']:checked").each(function () {
      checked.push(parseInt($(this).val()));
    });
    return checked;
  }

});
