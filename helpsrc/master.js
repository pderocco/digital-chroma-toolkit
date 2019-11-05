// This dismisses the popup.
function dismiss() {
    document.getElementById("popup-bg").style.display = "none"
    }

// This navigates to the specified page.
function page(name) {
    window.location = "#" + name
    }

// This issues an HTTP request for the popup data.
function popup(name) {
    var req = new XMLHttpRequest()
    req.responseType = "text"
    req.onload = popup_show
    req.open("GET", name + ".html")
    req.send()
    event.stopPropagation()
    }

// This stuffs the HTTP response into the popup and displays it.
function popup_show(event) {
    var bg = document.getElementById("popup-bg")
    var fg = document.getElementById("popup-fg")
    fg.innerHTML = event.target.responseText
    bg.style.display = "block"
    fg.style.left = (bg.offsetWidth - fg.offsetWidth) / 2 + "px"
    fg.style.top = (bg.offsetHeight - fg.offsetHeight) / 2 + "px"
    }

// This updates nav button text and links.
function update_nav() {
    var next, prev, title, up
    var page = ""
    var top = window.pageYOffset || document.documentElement.scrollTop

    // Do nothing until all four tables have been loaded.
    if (!nextlinks || !prevlinks || !uplinks || !titles)
        return

    // Find page containing the top of the viewport.
    try {
        pagelocs.forEach(function(id, pos) {
            if (pos <= top)
                page = id
            else
                throw null
            })
        }
    catch (e) {}

    // All done if no change.
    if (page === last_page)
        return
    last_page = page

    // Change URL in address bar, and title in tab.
    history.replaceState(null, titles[page], "master.html#" + page)
    document.title = titles[page]

    // If found, look up three nav links.
    if (page) {
        next = nextlinks[page]
        prev = prevlinks[page]
        up = uplinks[page]
        }

    // For each nav link, set up nav button.
    if (next) {
        nextlink.setAttribute("onclick", 
                "window.scrollTo(0, " + pagelocs.indexOf(next) + ")")
        nextlink.innerHTML = titles[next];
        }
    else {
        nextlink.setAttribute("onclick", null)
        nextlink.innerHTML = ""
        }
    if (prev) {
        prevlink.setAttribute("onclick", 
                "window.scrollTo(0, " + pagelocs.indexOf(prev) + ")")
        prevlink.innerHTML = titles[prev]
        }
    else {
        prevlink.setAttribute("onclick", null)
        prevlink.innerHTML = ""
        }
    if (up) {
        uplink.setAttribute("onclick", 
                "window.scrollTo(0, " + pagelocs.indexOf(up) + ")")
        uplink.innerHTML = titles[up]
        }
    else {
        uplink.setAttribute("onclick", null)
        uplink.innerHTML = ""
        }
    }

// The rest of this script is executed when loaded ----------------------------

// Call update_nav whenever the vertical position changes.
window.addEventListener("scroll", update_nav)

// Declare sparse array of pages indexed by their top positions.
var pagelocs = []

// Keep track of which page is at top of viewport.
var last_page

// Build array of vertical position of top of each page.
Array.prototype.forEach.call(document.getElementsByClassName("newpage"), 
    function(n) {
        if (n.id)
            pagelocs[Math.round(n.getBoundingClientRect().top 
                + (window.pageYOffset || document.documentElement.scrollTop))] 
                = n.id
        }
    )

// Declare tables of page names and their nav links and titles.
var nextlinks
var prevlinks
var uplinks
var titles

// Issue requests to populate above tables.
var nextreq = new XMLHttpRequest()
nextreq.responseType = "text"
nextreq.onload = function() {
    nextlinks = JSON.parse(nextreq.responseText)
    update_nav()
    }
nextreq.open("GET", "next.json")
nextreq.send()

var prevreq = new XMLHttpRequest()
prevreq.responseType = "text"
prevreq.onload = function() {
    prevlinks = JSON.parse(prevreq.responseText)
    update_nav()
    }
prevreq.open("GET", "prev.json")
prevreq.send()

var upreq = new XMLHttpRequest()
upreq.responseType = "text"
upreq.onload = function() {
    uplinks = JSON.parse(upreq.responseText)
    update_nav()
    }
upreq.open("GET", "up.json")
upreq.send()

var titlesreq = new XMLHttpRequest()
titlesreq.responseType = "text"
titlesreq.onload = function() {
    titles = JSON.parse(titlesreq.responseText)
    update_nav()
    }
titlesreq.open("GET", "titles.json")
titlesreq.send()
