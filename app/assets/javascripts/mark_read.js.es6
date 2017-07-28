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
  // this is the "throw stuff at the wall and see what sticks" approach.
  // I have no doubt that there is a one-line solution here. Better CSS + HTML structures
  // and I would have been good, I suspect.
  $(`.link_item[data-link-id=${link.id}]`).removeClass('read')
  $(`.link_item[data-link-id=${link.id}]`).find('input').removeClass('mark-as-unread')
  $(`.link_item[data-link-id=${link.id}]`).find('input').addClass("mark-as-read")
  $(`.link_item[data-link-id=${link.id}]`).find('input').val("Mark as Read");
  $(`.link_item[data-link-id=${link.id}]`).find(".read-status").text(link.read);
  $(`.link_item[data-link-id=${link.id}]`).attr('link-read',"false")

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
  $(`.link_item[data-link-id=${link.id}]`).attr('linkRead',"true")
}

function displayFailure(failureData){
  console.log("FAILED attempt to update Link: " + failureData.responseText);
}
