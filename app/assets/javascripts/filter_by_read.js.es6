$( document ).ready(function(){
  $(".filter-unread").click( function (event) {
    event.preventDefault()
    hideUnreadLinks()
  })

  $(".filter-read").click( function (event) {
    event.preventDefault()
    hideReadLinks()
  })
  $(".filter-none").click( function (event) {
    event.preventDefault()
    showAll()
  })
})


function hideUnreadLinks() {

  $('.link_item[data-link-read="true"]').addClass('hidden')
  $('.link_item[data-link-read="false"]').removeClass('hidden')

}

function hideReadLinks() {
  $('.link_item[data-link-read="false"]').addClass('hidden')
  $('.link_item[data-link-read="true"]').removeClass('hidden')
}

function showAll() {
  $('.link_item').removeClass('hidden')
}
