import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"

let cashier_target = document.querySelector("body")

if(cashier_target){
  console.log("tem elemento", cashier_target)
  doCall();
}

async function doCall(){
    const cashier_html = await getCashier();
    // console.log("cashier_html", cashier_html)

    // const token = await getToken();
    // const token = getToken(cashier_html);
    // console.log("token", token)

    if(cashier_html) {
      insertEl(cashier_target, cashier_html)
      connectWebSocket()
    }
}


// async function getToken() {
//    const response = await fetch("http://localhost:4000/api/token", {mode: 'cors'})
//     .then((response) => response.json())
//     .then((data) => data.token)
//     .catch((error) => console.error(error));

//   return response;
// }

async function getCashier() {
  const response = await fetch("http://localhost:4000/cashier", {credentials: 'include'})
          .then((response) => response.text())
          .catch((error) => console.error(error));

    return response;
  }

function insertEl(target, html) {
  let el = document.createElement("div")
  el.innerHTML = html

  target.prepend(el)
}

function connectWebSocket() {
  let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
  console.log({csrfToken})

  let liveSocket = new LiveSocket("ws://localhost:4000/live", Socket, {
  longPollFallbackMs: 2500,
  params: {_csrf_token: csrfToken}
  })
  
  liveSocket.connect()
}
