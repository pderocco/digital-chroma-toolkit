// This dismisses the popup
function dismiss() {
    document.getElementById("popup-bg").style.display = "none"
    }

// This navigates to the specified page.
function page(name) {
    if (name)
        window.location = name + ".html"
    }

// This issues an HTTP request for the popup data
function popup(name) {
    var req = new XMLHttpRequest()
    req.responseType = "text"
    req.onload = popup_show
    req.open("GET", name + ".html")
    req.send()
    event.stopPropagation()
    }

// This stuffs the HTTP response into the popup and displays it
function popup_show(event) {
    var bg = document.getElementById("popup-bg")
    var fg = document.getElementById("popup-fg")
    fg.innerHTML = event.target.responseText
    bg.style.display = "block"
    fg.style.left = (bg.offsetWidth - fg.offsetWidth) / 2 + "px"
    fg.style.top = (bg.offsetHeight - fg.offsetHeight) / 2 + "px"
    }
