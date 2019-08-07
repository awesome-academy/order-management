App.messages = App.cable.subscriptions.create('AddToBillsChannel',{
  received: function(data){
    if(data.type == 'add'){
      $('#bill-detail-chef-' + data.bill_id).append(this.renderBillDetails(data));
    } else if(data.type == 'destroy'){
      $('#bill-detail-' + data.bill_id + '-'  + data.bill_detail_id).html('');
    } else if (data.type == 'update'){
      $('#count-bill-detail-' + data.bill_id + '-'  + data.bill_detail_id).html(data.count);
    } else if (data.type == 'add_bill'){
      $('#list-bill-chef').append(this.renderBill(data));
    } else if (data.type == 'destroy_bill'){
      $('#bill-chef-' + data.bill_id).html('');
    }  else if (data.type == 'update_bill'){
      $('#bill-chef-' + data.bill_id).html('');
    }
  }, renderBillDetails: function(data) {
    let show = '<tr id="bill-detail-'+ data.bill_id +'-'+ data.bill_detail_id +'"><td><span>' 
    + data.stt + '</span></td><td><span><a href="' + data.href +'">' + data.name + '</a></span></td>'
    + '<td id="count-bill-detail-'+ data.bill_id +'-'+ data.bill_detail_id +'"><span>' + data.count 
    + '</span></td></tr>'
    return show;
  }, renderBill: function(data) {
    let show = '<tr><td><span>' + data.stt + '</span></td><td>' + data.name_customer + '</td><td><span>' 
    + data.name_user + '</span></td><td><a class="btn btn-info btn-sm" href="/bills/' + data.bill_id 
    + '/bill_details"><i class="fa fa-eye"></i></a></td></tr>'
    return show;
  }
});
