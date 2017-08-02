$( document ).ready(function(){
  $("#new_link_submit").click(function (event) {
    event.preventDefault();
    submitNewLink(event)
    // TRYING to reset the form fields/values/submit button w/ resetForm()
    // resetForm()
  })

})
//
// function resetForm() {
//   document.getElementById('new_link').reset()
//   // this was my last attempt to reset submit button, but no dice.
//   $('#new_link_submit').prop('disabled', false);
// }

function submitNewLink(e) {
  e.preventDefault();
  var $link = $(this).parents('.link_item');
  var linkId = $link.data('link-id');

  var link = {
    title: $("#link_title").val(),
    url: $('#link_url').val()
  }
  $('.flash_notices').text('')

  $.ajax({
    type: "POST",
    url: "/api/v1/links/",
    data: { link },
  })
  .done(function(markup) {
    if(markup.includes("div")) {
      addLinkToList(markup)

    } else {
      $('.flash_notices').text(markup)
      console.log(markup);
    }
  })
}

function addLinkToList(linkMarkup) {
  $('.links_list').prepend(linkMarkup)
  // $(`.link_item[data-link-id=${link.id}]`).removeClass('read')
}

function displayFailure(failureData){
  // when I console logged this, it printed to console, and when I manually appended some text
  // like "testing" to $('.flash_notices'), it worked, but the below didnt.
  $(".flash_notices").text("FAILED attempt to update Link: " + failureData.responseText);
}
