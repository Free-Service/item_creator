 

window.addEventListener("message", async function (event) {
  var item = event.data;

  if (item.state === "show") {
    $(".container").show();
    LoadItemsinList(item.items)
  }
});

document.onkeyup = function (data) {
  if (data.which == 27) {
    Close();
  }
};

function Close() {
  $(".container").hide();
  $.post("https://item_creator/exit", JSON.stringify({}));
}

function LoadItemsinList(ItemsList) {
  const itemListElement = document.getElementById('item-list');
  const itemList = JSON.parse(ItemsList);

  for (const item of itemList) {
  $(".item-list").append(`
    <li class="item">
      <span class="item-name">${item.name}</span>
      <span class="item-label">${item.label}</span>
      <span class="item-weight">${item.wieght}</span>
      <span class="item-rarity">Rarity ${item.rare}</span>
      <span class="item-can-remove">${item.can_remove}</span> 
      <button class="edit-button"><iconify-icon icon="ant-design:setting-outlined"></iconify-icon></button>
      <button class="delete-button"><iconify-icon icon="material-symbols:delete-outline"></iconify-icon></button>
    </li>
  `);
  }
}