$(document).bind('page:change', function() {
  $('.ckeditor').each(function() {
    CKEDITOR.replace($(this).attr('id'));
  });
});

function load_data_table() {
  return new Promise((resolve, reject) => {
    var data = {};
    data['name'] = $('#find_by_name').val();
    data['type'] = $('#find_by_type').val();
    data['status'] = $('#find_by_status').val();
    resolve(data);
  });
}

function load_data_user() {
  return new Promise((resolve, reject) => {
    var data = {};
    data['name'] = $('#find_by_name_user').val();
    data['role'] = $('#find_by_role_user').val();
    resolve(data);
  });
}

function load_data_table_manager() {
  return new Promise((resolve, reject) => {
    var data = {};
    data['name'] = $('#find_by_name_table').val();
    data['type'] = $('#find_by_type_table').val();
    resolve(data);
  });
}

function load_data_product() {
  return new Promise((resolve, reject) => {
    var data = {};
    data['name'] = $('#find_by_name_product').val();
    data['status'] = $('#find_by_status_product').val();
    resolve(data);
  });
}

function load_data_combo() {
  return new Promise((resolve, reject) => {
    var data = {};
    data['name'] = $('#find_by_name_combo').val();
    data['status'] = $('#find_by_status_combo').val();
    resolve(data);
  });
}

function call_ajax(url, type, data) {
  $.ajax({
    url: url,
    type: type,
    dataType: 'script',
    data: data
  });
}

$(document).on ('keyup', '#find_by_name', function(){
  load_data_table().then(data => {
    call_ajax('/search_table', 'POST', data);
  });
});

$(document).on ('change', '#find_by_type', function(){
  load_data_table().then(data => {
    call_ajax('/search_table', 'POST', data);
  });
});

$(document).on ('change', '#find_by_status', function(){
  load_data_table().then(data => {
    call_ajax('/search_table', 'POST', data);
  });
});

$(document).on ('keyup', '#find_by_name_user', function(){
  load_data_user().then(data => {
    call_ajax('/search_user', 'POST', data);
  });
});

$(document).on ('change', '#find_by_role_user', function(){
  load_data_user().then(data => {
    call_ajax('/search_user', 'POST', data);
  });
});

$(document).on ('keyup', '#find_by_name_table', function(){
  load_data_table_manager().then(data => {
    call_ajax('/search_table_manager', 'POST', data);
  });
});

$(document).on ('change', '#find_by_type_table', function(){
  load_data_table_manager().then(data => {
    call_ajax('/search_table_manager', 'POST', data);
  });
});

$(document).on ('keyup', '#find_by_name_product', function(){
  load_data_product().then(data => {
    call_ajax('/search_product', 'POST', data);
  });
});

$(document).on ('change', '#find_by_status_product', function(){
  load_data_product().then(data => {
    call_ajax('/search_product', 'POST', data);
  });
});

$(document).on ('keyup', '#find_by_name_combo', function(){
  load_data_combo().then(data => {
    call_ajax('/search_combo', 'POST', data);
  });
});

$(document).on ('change', '#find_by_status_combo', function(){
  load_data_combo().then(data => {
    call_ajax('/search_combo', 'POST', data);
  });
});

$(document).on ('click', '#stat', function(){
  let star_date = $('#start-date').val();
  let end_date = $('#end-date').val();
  $.ajax({
    url: '/stat',
    type: 'POST',
    dataType: 'json',
    data: {start_date: star_date, end_date: end_date},
    success: function(data){
      console.log(data);
    }
  });
});
