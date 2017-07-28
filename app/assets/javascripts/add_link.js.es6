$( document ).ready(function(){
  $("#create_new_link").submit( function (event) {
    event.preventDefault()
    submitNewLink(event)
    $(".flash_notices").append("FAILED attempt to update Link: " + failureData.responseText);

  })

})

function resetForm() {
  document.getElementById('new_link').reset()
}

function submitNewLink(e) {
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
  }).then(addLinkToList)
    .fail(displayFailure)
}

function addLinkToList(linkMarkup) {
  $('.links_list').prepend(linkMarkup)
  // $(`.link_item[data-link-id=${link.id}]`).removeClass('read')
}

function displayFailure(failureData){
  $(".flash_notices").text("FAILED attempt to update Link: " + failureData.responseText);
  console.log("FAILED attempt to update Link: " + failureData.responseText);
}
