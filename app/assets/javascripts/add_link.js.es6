$( document ).ready(function(){
  $("#create_new_link").submit( function (event) {
    event.preventDefault()
    submitNewLink(event)
  })
})

function getFormData() {
  console.log("get form data here");
}

function submitNewLink(e) {
  console.log("submitting shit");
  e.preventDefault();
  var $link = $(this).parents('.link_item');
  var linkId = $link.data('link-id');

  var link = {
    title: $("#link_title").val(),
    url: $('#link_url').val()
  }

  $.ajax({
    type: "POST",
    url: "/api/v1/links/",
    data: { link },
  }).done(function (newLinkMarkup) {
    addLinkToList(newLinkMarkup)
  });
}

function addLinkToList(linkMarkup) {
  $('.links_list').prepend(linkMarkup)
  // $(`.link_item[data-link-id=${link.id}]`).removeClass('read')
}


function displayFailure(failureData){
  console.log("FAILED attempt to update Link: " + failureData.responseText);
}
