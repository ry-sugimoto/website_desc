(() => {
  if (document.getElementById("overlay-dialog")) return

  const overlay = document.createElement("div")
  overlay.id = "overlay-dialog"
  overlay.style.position = "fixed"
  overlay.style.width = "360px"
  overlay.style.height = "240px"
  overlay.style.backgroundColor = "#f5f5f5"
  overlay.style.border = "1px solid #ccc"
  overlay.style.boxShadow = "0 4px 8px rgba(0, 0, 0, 0.2)"
  overlay.style.padding = "10px"
  overlay.style.zIndex = "9999"
  overlay.style.top = "10px"
  overlay.style.right = "10px"

  const divActions = document.createElement("div")
  divActions.style.padding = "16px 16px"
  divActions.style.display = "flex"
  divActions.style.justifyContent = "center"

  // 概要ボタン
  const executeBtn = createButtonElement()
  executeBtn.id = "execute-btn"
  executeBtn.textContent = "概要表示"
  executeBtn.onclick = fetchDescription
  divActions.appendChild(executeBtn)

  // 位置変更ボタン
  const divPosBtns = document.createElement("div")
  divPosBtns.style.marginLeft = "auto"
  const positions = [
    { name: "右上", top: "10px", right: "10px", bottom: "", left: "", icon: 'icon/top_right.svg' },
    { name: "右下", top: "", right: "10px", bottom: "10px", left: "", icon: 'icon/bottom_right.svg' },
    { name: "左下", top: "", right: "", bottom: "10px", left: "10px", icon: 'icon/bottom_left.svg' },
    { name: "左上", top: "10px", right: "", bottom: "", left: "10px", icon: 'icon/top_left.svg' }
  ]

  positions.forEach((pos) => {
    const btn = createButtonElement()
    const img = document.createElement("img");
    img.src = chrome.runtime.getURL(pos.icon);
    img.width = 32;
    img.height = 32;
    btn.appendChild(img);
    btn.style.margin = "5px"
    btn.onclick = () => {
      overlay.style.top = pos.top
      overlay.style.right = pos.right
      overlay.style.bottom = pos.bottom
      overlay.style.left = pos.left
    }
    divPosBtns.appendChild(btn)
  })
  divActions.appendChild(divPosBtns)
  overlay.appendChild(divActions)

  // 概要表示
  const description = document.createElement("p")
  description.id = "desc-text"
  description.style.padding = "16px 16px"
  description.textContent = ""
  overlay.appendChild(description)

  document.body.appendChild(overlay)
})()

function createButtonElement() {
  const btn = document.createElement("button")
  btn.style.border = "solid black"
  btn.style.backgroundColor = "#d3d3d3"
  return btn
}

function fetchDescription() {
  const desc = getWebsiteDesc(window.location.href)
    .then(desc => {
      const descElem = document.getElementById("desc-text")
      descElem.textContent = desc
    })
}

async function getWebsiteDesc(url) {
  const params = { url: url }
  const query = new URLSearchParams(params)
  const response = await fetch(`http://localhost:3000/api/website/description?${query}`)
  if (response.ok) {
    const data = await response.json()
    return data.description
  }
  else {
    return '概要の取得に失敗しました。'
  }
}