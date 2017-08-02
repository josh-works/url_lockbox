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

  filterByText()
})


function filterByText() {
  $('#filter-by-text').keyup(function() {
    var text = $(this).children().val()
    var links = $('.link_item')
    var regex = new RegExp(text, 'gi')
    
    links.map(function() {
      var title = $(this).find('h3').html()
      var url = $(this).find('a').html()
      this.style.display = 'none'
      if (title.match(regex) || url.match(regex)){
        this.style.display = ''
      }
    })
  })
}

// all of this class adding/removing was crap. Should have just toggled a status
// some how. It broke because (I think) any item might have the same class added
// twice, or removed a class that didn't exist. This was a most... inelegant attempt
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
