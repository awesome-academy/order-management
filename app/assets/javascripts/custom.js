$(document).bind('page:change', function() {
  $('.ckeditor').each(function() {
    CKEDITOR.replace($(this).attr('id'));
  });
});

function call_ajax() {
  let name = $('#find_by_name').val();
  let type = $('#find_by_type').val();
  let status = $('#find_by_status').val();
  $.ajax({
    url: '/search_table',
    type: 'POST',
    dataType: 'script',
    data: {name: name, type: type, status: status}
  });
}

$(document).on("turbolinks:load",function(){
  $(document).on ('keyup', '#find_by_name', function(){
    call_ajax();
  });
})

$(document).on ('change', '#find_by_type', function(){
  call_ajax();
});

$(document).on ('change', '#find_by_status', function(){
  call_ajax();
});
