$( document ).ready(function(){
  $("body").on("click", ".mark-as-read", markAsRead)
  $("body").on("click", ".mark-as-unread", markAsUnread)
})

function markAsUnread(e) {
  e.preventDefault();
  var $link = $(this).parents('.link_item');
  var linkId = $link.data('link-id');

  $.ajax({
    type: "PATCH",
    url: "/api/v1/links/" + linkId,
    data: { read: false },
  }).then(setLinkToUnread)
    .fail(displayFailure);
}

function setLinkToUnread(link) {
  $(`.link_item[data-link-id=${link.id}]`).removeClass('read')
  $(`.link_item[data-link-id=${link.id}]`).find('input').removeClass('mark-as-unread')
  $(`.link_item[data-link-id=${link.id}]`).find('input').addClass("mark-as-read")
  $(`.link_item[data-link-id=${link.id}]`).find('input').val("Mark as Read");
}

function markAsRead(e) {
  e.preventDefault();
  var $link = $(this).parents('.link_item');
  var linkId = $link.data('link-id');

  $.ajax({
    type: "PATCH",
    url: "/api/v1/links/" + linkId,
    data: { read: true },
  }).then(setLinkToRead)
    .fail(displayFailure);
}

function setLinkToRead(link) {
  $(`.link_item[data-link-id=${link.id}]`).find(".read-status").text(link.read);
  $(`.link_item[data-link-id=${link.id}]`).addClass('read')
  $(`.link_item[data-link-id=${link.id}]`).find('input').addClass('mark-as-unread')
  $(`.link_item[data-link-id=${link.id}]`).find('input').removeClass("mark-as-read")
  $(`.link_item[data-link-id=${link.id}]`).find('input').val("Mark as Unread");

}

function displayFailure(failureData){
  console.log("FAILED attempt to update Link: " + failureData.responseText);
}
