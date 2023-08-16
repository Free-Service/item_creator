

window.addEventListener("message", async function (event) {
  var item = event.data;

  if (item.state === "show") {
    $("body").show();
    document.getElementsByTagName("body")[0].style.display = "flex";
    LoadItemsinList(item.items)
  }
});

document.onkeyup = function (data) {
  if (data.which == 27) {
    Close();
  }
};

function Close() {
  $("body").hide();
  $.post("https://item_creator/exit", JSON.stringify({}));
}

function LoadItemsinList(ItemsList) {
  const itemListElement = document.getElementById('item-list');
  const itemList = JSON.parse(ItemsList);

  for (const item of itemList) {
    const listItem = document.createElement('li');
    listItem.textContent = `${item.label} - Weight: ${item.weight}`;
    itemListElement.appendChild(listItem);
  }
}
