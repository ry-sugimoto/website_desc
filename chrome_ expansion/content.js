(() => {
  if (document.getElementById("overlay-dialog")) return

  const overlay = document.createElement("div");
  overlay.id = "overlay-dialog";
  overlay.style.position = "fixed";
  overlay.style.width = "320px";
  overlay.style.height = "320px";
  overlay.style.backgroundColor = "#f5f5f5";
  overlay.style.border = "1px solid #ccc";
  overlay.style.boxShadow = "0 4px 8px rgba(0, 0, 0, 0.2)";
  overlay.style.padding = "10px";
  overlay.style.zIndex = "9999";
  overlay.style.top = "10px";
  overlay.style.right = "10px";

  const divActions = document.createElement("div")
  divActions.style.padding="16px 16px"
  divActions.style.display="flex"
  divActions.style.justifyContent="center"

  // 概要ボタン
  const executeBtn = document.createElement("button")
  executeBtn.id = "execute-btn"
  executeBtn.textContent = "概要ボタン"
  divActions.appendChild(executeBtn)

  // 位置変更ボタン
  const divPosBtns = document.createElement("div")
  divPosBtns.style.marginLeft="auto"

  const positions = [
    { name: "右上", top: "10px", right: "10px", bottom: "", left: "" },
    { name: "右下", top: "", right: "10px", bottom: "10px", left: "" },
    { name: "左下", top: "", right: "", bottom: "10px", left: "10px" },
    { name: "左上", top: "10px", right: "", bottom: "", left: "10px" }
  ];

  positions.forEach((pos) => {
    const btn = document.createElement("button");
    btn.textContent = pos.name;
    btn.style.margin = "5px";
    btn.onclick = () => {
      overlay.style.top = pos.top;
      overlay.style.right = pos.right;
      overlay.style.bottom = pos.bottom;
      overlay.style.left = pos.left;
    };
    divPosBtns.appendChild(btn);
  });
  divActions.appendChild(divPosBtns)
  overlay.appendChild(divActions)

  // 概要表示
  const description = document.createElement("p")
  description.id="desc-text"
  description.style.padding="16px 16px"
  description.textContent = ""
  overlay.appendChild(description)

  document.body.appendChild(overlay);
})();
