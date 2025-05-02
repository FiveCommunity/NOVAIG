$(document).ready(function () {
  requestOrgs();
});

var goalsTypes
var membersList
var orgName = "";
var orgGroup, orgPrefix = "";
var promoveDemissId = 0;
var cacheMembers;
var actionBank = "deposit";
var selectedOffices = [];
var globalPermissions = {};
var globalIsLeader = true;
var discordUrl = ''

function openDiscord() {
  window.invokeNative('openUrl', discordUrl)
}

function updateDiscordUrl({ target }) {
  discordUrl = target.value
}

function updateDiscord() {
  if (discordUrl.startsWith('https://discord.gg/')) {
    discordUrl = document.querySelector('.discord > input#url').value
    fetch('https://bm_module/updateDiscord', {
      method: 'POST',
      body: JSON.stringify({ discordUrl })
    })
  } else {
    console.log('Não foi possivel a url não é de discord!')
  }
}

function requestOrgs() {
  $.post("https://bm_module/requestOrgs", JSON.stringify({}), (data) => {
    membersList = data.Members;
    setListMembers(data["Members"]);
    setTotalMembers(data["TotalMembers"]);
    setBankValue(data["BankValue"]);
    setDescription(data["Description"]);
    setTotalMembersActive(data["TotalMembersActive"]);
    setMembersOn(data["TotalMembersActive"]);
    setNameOrganization(data["Organization"]);
    setChatMessages(data["Chat"]);
    setPermissions(data["Leader"], data["Permissions"]);
    setPlayerInfos(data["Name"], data["User_id"], data["Avatar"]);
    setDiscord(data['DiscordUrl'])
    orderBy('role')
  });
}

function setDiscord(discord) {
  discordUrl = discord
}

function orderBy (type) {
  const importanceRoles = ['Novato', 'Membro', 'Recrutador', 'Gerente','Sub-Lider', 'Lider'];
  if (type === 'id') {
    membersList.sort((a, b) => a.user_id - b.user_id);
    setListMembers(membersList);
  }

  if (type === 'role') {
    membersList.sort((a, b) => importanceRoles.indexOf(b.groupPrefix) - importanceRoles.indexOf(a.groupPrefix));
    setListMembers(membersList);
  }
}

function setPlayerInfos(name, user_id, avatar) {
  $(".name_player_orgs").html(name);
  $(".passaport_player_orgs").html("#" + user_id);
  $(".avatar_orgs").css("background", "url(" + avatar + ")");
}

function setPermissions(isLeaderProp, permissionsProp) {
  globalIsLeader = isLeaderProp;
  if (!isLeaderProp) {
    if (!permissionsProp.invite) {
      $(".button_invit_orgs").hide();
    }

    if (!permissionsProp.message) {}

    if (!permissionsProp.demote) {}

    if (!permissionsProp.chat) {
      $(".send-message-orgs").attr("disabled", "disabled");
    }

    globalPermissions = permissionsProp;
  }
}

function setChatMessages(chat) {
  $(".list-messages").html("");

  chat.map((item, index) => {
    $(".list-messages").append(`    
            <div class="item-messages-orgs">
                <div class="author-message-chat-orgs">
                    ${item["author"]}
                </div>
                <div class="message-sent-orgs">
                    ${item["message"]}
                </div>
            </div>
        `);
  });

  var chatOverflow = document.getElementById("scroll-orgs");
  var chatOverflow2 = document.getElementById("scroll-orgs2");
  chatOverflow.scrollTo({
    top: chatOverflow.scrollHeight,
    behavior: "instant",
  });
  chatOverflow2.scrollTo({
    top: chatOverflow2.scrollHeight,
    behavior: "instant",
  });
}

function orderBy(type) {
  const importanceRoles = ['Novato', 'Membro', 'Recrutador', 'Gerente', 'Sub-Lider', 'Lider'];
  if (type === 'id') {
    membersList.sort((a, b) => a.user_id - b.user_id);
    setListMembers(membersList);
  }

  if (type === 'role') {
    membersList.sort((a, b) => importanceRoles.indexOf(b.groupPrefix) - importanceRoles.indexOf(a.groupPrefix));
    setListMembers(membersList);
  }
}

function setListMembers(members) {
  $(".list-members-overflow-orgs").html("");
  cacheMembers = members;
  members.map((item, index) => {
    $(".list-members-overflow-orgs").append(`
            <div class="item-members-orgs">
                <div class="item-top-table-orgs">
                    <div class="column">
                        <div class="name-list-members">
                            ${item["name"]}
                        </div>
                        <div class="pass-list-members">
                            #${item["user_id"]}
                        </div>
                    </div>
                </div>
                <div class="item-top-table-orgs">
                    ${item["groupPrefix"]}
                </div>
                <div class="item-top-table-orgs">
                    ${item["online"] == true ? "Online" : "Offline"}
                </div>
                <div class="item-top-table-orgs">
                    ${item["last_login"]}
                </div>

                
                <div class="promove-member-orgs" onclick="openModal('promove', '${
                  item["user_id"]
                }', '${item["name"]} [${item["user_id"]}]')">
                    <img src="orgs/nui/images/promove.svg" alt="">
                </div>
                <div class="trash-member-orgs" onclick="openModal('demiss', '${
                  item["user_id"]
                }', '${item["name"]} [${item["user_id"]}]')">
                    <img src="orgs/nui/images/trash.svg" alt="">
                </div>
            </div>
      `);
  });
}

function exit() {
  $.post(
    "http://bm_module/onClose",
    JSON.stringify({
      close: "orgs",
    })
  );
}

function setTotalMembers(totalMembers) {
  $(".totalMembers").html(totalMembers);
}

function setBankValue(bankValue) {
  $(".balance").html(bankValue);
}

function setDescription(description) {
  $(".errand_response").html(description);
}

function setTotalMembersActive(totalMembersActive) {
  if (totalMembersActive >= 1)
    $(".members_on_orgs").html(
      `<span>${totalMembersActive}</span> membros ativos`
    );
  else
    $(".members_on_orgs").html(
      `<span>${totalMembersActive}</span> membro ativo`
    );
}

function setMembersOn(membersOn) {
  $(" .totalMembersActive").html(membersOn);
}

function setNameOrganization(nameOrganization) {
  $(".org_name b").html(nameOrganization.toUpperCase());
  orgName = nameOrganization;
}

function closeModal() {
  $(".content-outside-modal").fadeOut(500);
  $(".modal-orgs").fadeOut(500);
}

function openModal(section, id, name) {
  $(".close-section-modal").hide();
  $(".open-modal-" + section).show();
  $(".content-outside-modal").fadeIn(500);
  $(".modal-orgs").fadeIn(500);

  $(".list-offices").hide(500);
  $(".passaport-contract-orgs").val("");
  $(".passport-orgs").fadeIn();
  $(".display-none").hide();
  $(".send-name").css("background", "url(orgs/nui/images/check.svg)");
  $(".send-name").css("background-size", "100% 100%");

  let changeAudio = new Audio("orgs/nui/audio/change.mp3");
  changeAudio.volume = 0.5;
  changeAudio.play();

  if (section == "promove" || section == "demiss") {
    promoveDemissId = id;
    $(".passaport-demiss b").html(id);
  }

  if (section == "promove") {
    openPromove(name);
  }
}

function sendName() {
  $.post(
    "http://bm_module/requestPlayerName",
    JSON.stringify({
      plyid: Number($(".passaport-contract-orgs").val()),
    }),
    (data) => {
      $(".passport-orgs").hide();
      $(".display-none").fadeIn(500);
      $(".send-name").css("background", "url(orgs/nui/images/checkon.svg)");
      $(".send-name").css("background-size", "100% 100%");
      $(".name-orgs b").html(data.name);

      requestOrgs();
      $(".list-offices").html("");
      data.list.map((item, index) => {
        $(".list-offices").append(`
                <div class="item-offices" onclick="closeList(this)" data-group="${item.group}" data-prefix="${item.prefix}">
                    ${item.prefix}
                </div>
            `);
      });

      orgGroup = data.list[0].group;
      orgPrefix = data.list[0].prefix;
      $(".office-orgs").html(orgPrefix);
    }
  );
}

function invitePlayer() {
  $(".content-outside-modal").fadeOut(500);
  $(".modal-orgs").fadeOut(500);
  $.post(
    "http://bm_module/invitePlayer",
    JSON.stringify({
      plyid: Number($(".passaport-contract-orgs").val()),
      org: orgName,
      group: orgGroup,
      prefix: orgPrefix,
    }),
    (data) => {
      requestOrgs();
    }
  );
}

function openList() {
  $(".list-offices").fadeIn(500);
}

function closeList(attr) {
  $(".list-offices").fadeOut(500);
  orgGroup = $(attr).data("group");
  orgPrefix = $(attr).data("prefix");

  $(".office-orgs").html(orgPrefix);
}

function leaveOrg() {
  $.post(
    "http://bm_module/leaveOrg",
    JSON.stringify({
      org: orgName,
    }),
    (data) => {
      exit();
    }
  );
}

function openPromove(name) {
  $.post(
    "http://bm_module/requestPromovePlayer",
    JSON.stringify({
      plyid: Number(promoveDemissId),
    }),
    (data) => {
      $(".list-offices").html("");
      data.list.map((item, index) => {
        $(".list-offices").append(`
                <div class="item-offices" onclick="closeList(this)" data-group="${item.group}" data-prefix="${item.prefix}">
                    ${item.prefix}
                </div>
            `);
      });

      orgGroup = data.list[0].group;
      orgPrefix = data.list[0].prefix;
      $(".office-orgs").html(orgPrefix);
      $(".name-promove b").html(name);
    }
  );
}

function confirmPromove() {
  $(".content-outside-modal").fadeOut(500);
  $(".modal-orgs").fadeOut(500);
  $.post(
    "http://bm_module/promovePlayer",
    JSON.stringify({
      plyid: Number(promoveDemissId),
      org: orgName,
      group: orgGroup,
    }),
    (data) => {
      requestOrgs();
    }
  );
}

function demissPlayer() {
  $(".content-outside-modal").fadeOut(500);
  $(".modal-orgs").fadeOut(500);
  $.post(
    "http://bm_module/demotePlayer",
    JSON.stringify({
      plyid: Number(promoveDemissId),
      org: orgName,
    }),
    (data) => {
      requestOrgs();
    }
  );
}

function searchList() {
  let newMembersOrgs = cacheMembers.filter(member => {
    return member.name.toLowerCase().includes($('.search-member-orgs').val().toLowerCase()) || member.user_id.toString().includes($('.search-member-orgs').val().toLowerCase());
  });
  $(".list-members-overflow-orgs").html("");

  newMembersOrgs.map((item, index) => {
    $(".list-members-overflow-orgs").append(`
            <div class="item-members-orgs">
                <div class="item-top-table-orgs">
                    <div class="column">
                        <div class="name-list-members">
                            ${item["name"]}
                        </div>
                        <div class="pass-list-members">
                            #${item["user_id"]}
                        </div>
                    </div>
                </div>
                <div class="item-top-table-orgs">
                    ${item["groupPrefix"]}
                </div>
                <div class="item-top-table-orgs">
                    ${item["online"] == true ? "Online" : "Offline"}
                </div>
                <div class="item-top-table-orgs">
                    ${item["last_login"]}
                </div>

                
                <div class="promove-member-orgs" onclick="openModal('promove', '${
                  item["user_id"]
                }', '${item["name"]} [${item["user_id"]}]')">
                    <img src="orgs/nui/images/promove.svg" alt="">
                </div>
                <div class="trash-member-orgs" onclick="openModal('demiss', '${
                  item["user_id"]
                }', '${item["name"]} [${item["user_id"]}]')">
                    <img src="orgs/nui/images/trash.svg" alt="">
                </div>
            </div>
    `);
  });
}

function setMenuActive(menu) {

  $(".section").hide();
  $(".section-" + menu).fadeIn(500);

  $(".item_menu_orgs_select").removeClass("item_menu_orgs_select");
  $(".item_menu_orgs_" + menu).addClass("item_menu_orgs_select");

  if (menu == "bank") {
    requestBank();
  }

  if (menu === 'farms') {
    requestConfigDatas();
  }

  if (menu == 'config') {
    if (!globalIsLeader) {
      let errorAudio = new Audio('orgs/nui/audio/error.mp3');
      errorAudio.volume = 0.3;
      errorAudio.play();

      $('.section-config').html(`
            <b>Opa! Essa area é restrita!</b>
        `)

      $('.section-config').addClass('restrited')
      return;
    }
    requestOffices()
  }


  let changeAudio = new Audio("orgs/nui/audio/change.mp3");
  changeAudio.volume = 0.5;
  changeAudio.play();
}

function setMenuBank(menu) {
  actionBank = menu;
  $(".button-bank-active-orgs").removeClass("button-bank-active-orgs");
  $(".button-bank-orgs-" + menu).addClass("button-bank-active-orgs");

  let changeAudio = new Audio("orgs/nui/audio/change.mp3");
  changeAudio.volume = 0.5;
  changeAudio.play();
}

function requestBank() {
  $.post("https://bm_module/requestBank", JSON.stringify({}), (data) => {
    $(".result-bank").html("<span>R$</span>" + data["BankValue"]);

    $(".list-extracts-orgs").html("");
    data["Historic"].reverse().map((item, index) => {
      $(".list-extracts-orgs").append(`
                <div class="item-extracts-orgs">
                    <div class="sub-section-item-extracts-orgs">
                        ${item.name} <span>#${item.user_id}</span>
                    </div>
                    <div class="sub-section-item-extracts-orgs">
                        ${item.action}
                    </div>
                    <div class="sub-section-item-extracts-orgs">
                        ${item.value}
                    </div>
                </div>
            `);
    });
  });
}

function confirmActionBank() {
  if (!globalIsLeader) {
    if (actionBank == "withdraw" && !globalPermissions.withdraw) {
      let errorAudio = new Audio("orgs/nui/audio/error.mp3");
      errorAudio.volume = 0.3;
      errorAudio.play();
      return;
    }
    if (actionBank == "deposit" && !globalPermissions.deposit) {
      let errorAudio = new Audio("orgs/nui/audio/error.mp3");
      errorAudio.volume = 0.3;
      errorAudio.play();
      return;
    }
  }

  $.post(
    "https://bm_module/confirmBank",
    JSON.stringify({
      value: Number($(".value-bank-orgs-input").val()),
      action: actionBank,
      org: orgName,
    }),
    (data) => {
      let confirmAudio = new Audio("orgs/nui/audio/confirm.mp3");
      confirmAudio.volume = 0.3;
      confirmAudio.play();

      $(".result-bank").html("<span>R$</span>" + data["BankValue"]);
      $(".value-bank-orgs-input").val("");

      $(".list-extracts-orgs").html("");
      data["Historic"].reverse().map((item, index) => {
        $(".list-extracts-orgs").append(`
                <div class="item-extracts-orgs">
                    <div class="sub-section-item-extracts-orgs">
                        ${item.name} <span>#${item.user_id}</span>
                    </div>
                    <div class="sub-section-item-extracts-orgs">
                        ${item.action}
                    </div>
                    <div class="sub-section-item-extracts-orgs">
                        ${item.value}
                    </div>
                </div>
            `);
      });
    }
  );
}

var delayMessage = false;
$("#input-chat1").on("keyup", function (e) {
  if (e.key === "Enter" || e.keyCode === 13) {
    if ($("#input-chat1").val().length >= 1 && delayMessage == false) {
      $.post(
        "https://bm_module/addMessage",
        JSON.stringify({
          message: $("#input-chat1").val(),
        }),
        (data) => {
          if (!data) {
            return;
          }

          $("#input-chat1").val("");
          let confirmAudio = new Audio("orgs/nui/audio/confirm.mp3");
          confirmAudio.volume = 0.3;
          confirmAudio.play();
          delayMessage = true;

          setTimeout(() => {
            delayMessage = false;
          }, 5000);
          setChatMessages(data);
        }
      );
    }
  }
});

$("#input-chat2").on("keyup", function (e) {
  if (e.key === "Enter" || e.keyCode === 13) {
    if ($("#input-chat2").val().length >= 1 && delayMessage == false) {
      $.post(
        "https://bm_module/addMessage",
        JSON.stringify({
          message: $("#input-chat2").val(),
        }),
        (data) => {
          $("#input-chat2").val("");
          let confirmAudio = new Audio("orgs/nui/audio/confirm.mp3");
          confirmAudio.volume = 0.3;
          confirmAudio.play();
          delayMessage = true;

          setTimeout(() => {
            delayMessage = false;
          }, 5000);
          setChatMessages(data);
        }
      );
    }
  }
});





function selectOffices(officeProp, indexProp, attr) {
  $(".selectOfficesOrgs").removeClass("selectOfficesOrgs");
  $(attr).addClass("selectOfficesOrgs");
  let changeAudio = new Audio("orgs/nui/audio/change.mp3");
  changeAudio.volume = 0.5;
  changeAudio.play();

  $.post(
    "https://bm_module/requestSelectOffice",
    JSON.stringify({
      index: indexProp,
    }),
    (data) => {
      $(".edit_patents_orgs").html("");

      selectedOffices = data;

      Object.values(data).map((item, index) => {
        if (item.status) {
          $(".edit_patents_orgs").append(`
                    <div class="item_edit_patents_orgs">
                        <b>${item.name}</b>
                        <p>${item.description}.</p>
                        <div class="switch_perm_orgs">
                            <div class="on_orgs" onclick="setOfficePerm('${
                              Object.keys(data)[index]
                            }', this)"><img src="orgs/nui/images/on.svg" alt=""></div>
                        </div>
                    </div>
                `);
        }

        if (!item.status) {
          $(".edit_patents_orgs").append(`
                    <div class="item_edit_patents_orgs">
                        <b>${item.name}</b>
                        <p>${item.description}.</p>
                        <div class="switch_perm_orgs">
                            <div class="off_orgs" onclick="setOfficePerm('${
                              Object.keys(data)[index]
                            }',this)"><img src="orgs/nui/images/off.svg" alt=""></div>
                        </div>
                    </div>
                `);
        }
      });

      $(".edit_patents_orgs").append(`
            <div class="content_button_confirm_patents_orgs">
                <div class="button_confirm_patents_orgs" onclick="confirmSaveOffices('${indexProp}')">
                    SALVAR
                </div>
            </div>
        `);
    }
  );
}

function setOfficePerm(keyProp, attrProp) {
  let changeAudio = new Audio("orgs/nui/audio/change.mp3");
  changeAudio.volume = 0.5;
  changeAudio.play();

  switch (selectedOffices[keyProp].status) {
    case false:
      selectedOffices[keyProp].status = true;
      $(attrProp).removeClass("off_orgs");
      $(attrProp).addClass("on_orgs");
      $(attrProp).html('<img src="orgs/nui/images/on.svg" alt="">');

      break;

    case true:
      selectedOffices[keyProp].status = false;
      $(attrProp).removeClass("on_orgs");
      $(attrProp).addClass("off_orgs");
      $(attrProp).html('<img src="orgs/nui/images/off.svg" alt="">');

      break;
  }
}

function confirmSaveOffices(indexProp) {
  let confirmAudio = new Audio("orgs/nui/audio/confirm.mp3");
  confirmAudio.volume = 0.3;
  confirmAudio.play();
  $.post(
    "https://bm_module/saveOffice",
    JSON.stringify({
      offices: selectedOffices,
      index: indexProp,
    }),
    (data) => {}
  );
}


var currentType = ''
var inputValue = '';

//Config 
function setConfigOptions(options) {
  document.querySelector('.section-farms .header select').innerHTML = ""
  options.forEach(option => {
    document.querySelector('.section-farms .header select').innerHTML += `
      <option value="${option.value}">${option.name}</option>
    `
  })
}

function setConfigType(type) {
  fetch('http://bm_module/setConfigType', {
      method: 'POST',
      body: JSON.stringify({
        type
      })
    })
    .then(res => res.json())
    .then(data => {
      inputValue = new Date().getDate();
      loadConfigData(data)
      currentType = type
    }).catch(err => console.log(err));
}

async function requestConfigDatas() {
  await fetch('http://bm_module/requestConfigDatas')
    .then(res => res.json())
    .then(data => {
      inputValue = new Date().getDate();
      loadConfigData(data)
      setConfigOptions(data.options);
      currentType = data.firstType
    }).catch(err => console.log(err));
}

function openModalGoal() {
  document.querySelector('#modalGoal').style.display = 'flex';
}


function loadConfigData(data) {
  document.querySelector('.section-farms .content').innerHTML = '';
  document.querySelector('.section-farms .content').innerHTML = `
    <div class="calendar-table">
      <div class="calendar">
        <input type="date" id="date-input" onchange="sendNewDate(event)">
        <label for="date-input">
          <i class="fa-solid fa-calendar-days"></i>
        </label>
      </div>
      <div class="table-head">
        <p>Nome</p>
        <p>Cargo</p>
        <p>Item</p>
        <p>Quantidade</p>
        <p>Pagamento</p>
      </div>
      <div class="table-body">
        ${data.goal.map(member => {
          return ` 
            <div class="table-row">
              <p>${member.name} <strong>#${member.user_id}</strong></p>
              <p>${member.rank}</p>
              <p>${member.item}</p>
              <p>${Number(member.amount).toLocaleString('pt-br')}</p>
              ${member.reward 
                ? `
                  <div class="image">
                    <img src="orgs/nui/images/checkGoals.svg" alt="">
                  </div>
                  `
                : '<p>N/A</p>'}
            </div>
          `
        }).join('')}
      </div>
    </div>
    <div class="your-goals">
      <h2>SUAS METAS</h2>
      <p>Mensal: <strong>${data.info.playerMonthly}/${data.info.maxMonthly} ${data.info.itemName}</strong></p>
      <p>Diária: <strong>${data.info.playerDailyFarm}/${data.info.maxDaily} ${data.info.itemName}</strong></p>
      <p>Pagamento: <strong>$${Number(data.info.payment).toLocaleString('pt-br')}</strong></p>
      <p id="viewDay">Dia visualiado: <strong>${inputValue}</strong></p>
      <div class="goals-buttons">
        ${globalIsLeader ? '<button onclick="openModalGoal()">EDITAR</button>' : ''}
        <button 
          onclick="reward()"
          style="pointer-events: ${data.info.playerRewarded === false && data.info.playerDailyFarm >= data.info.maxDaily ? 'all' : 'none'}"
          class="${data.info.playerRewarded === false && data.info.playerDailyFarm >= data.info.maxDaily ? 'redeemable' : ''}"
        >RESGATAR</button>
      </div>
    </div>
  `
}

function reward() {
  fetch('http://bm_module/reward', {
    method: 'POST',
    body: JSON.stringify({
      currentType
    })
  })
  fetch('http://bm_module/onClose', {
    method: 'POST',
    body: JSON.stringify({
      close: 'orgs'
    })
  })
}


function saveNewGoals() {
  const allValues = document.querySelectorAll('#modalGoal input');
  if (allValues[0].value === '' || allValues[1].value === '' || allValues[2].value === '' || allValues[0].value < 0 || allValues[1].value < 0 || allValues[2].value < 0) return
  fetch('http://bm_module/newGoals', {
    method: 'POST',
    body: JSON.stringify({
      currentType,
      monthly: allValues[0].value,
      daily: allValues[1].value,
      payment: allValues[2].value,
    })
  }).then(res => res.json()).then(data => {
    loadConfigData(data)
    allValues[0].value = '';
    allValues[1].value = '';
    allValues[2].value = '';
    document.querySelector('#modalGoal').style.display = 'none';
  });
}

function sendNewDate({
  target
}) {
  inputValue = document.querySelector('.calendar input').value
  fetch('http://bm_module/newDate', {
    method: 'POST',
    body: JSON.stringify({
      day: target.value.split('-')[2],
      month: target.value.split('-')[1],
      type: currentType
    })
  }).then(res => res.json()).then(data => {
    loadConfigData(data)
    document.querySelector('#viewDay').innerHTML = `Dia visualiado: <strong>${inputValue.split('-')[2]}`
  });
}


window.addEventListener('keydown', ({
  key
}) => {
  if (key === 'Escape' && document.querySelector('#modalGoal').style.display === 'flex') {
    document.querySelector('#modalGoal').style.display = 'none';
  }
})

function requestOffices() {
  $.post('https://bm_module/requestOffices', JSON.stringify({}), (data) => {
    $('.patents_orgs').html('');
    $('.edit_patents_orgs').html('');

    let indexProp = data[0][data[0].length - 1].index;

    data[0].reverse().map((item, index) => {
      $('.patents_orgs').append(`
        <div class="item_patents_orgs item_patents_orgs${index}" onclick="selectOffices('${item.prefix}', '${item.index}', this)">
          ${item.prefix}
        </div>
      `)
    })

    selectedOffices = data[1];

    Object.values(data[1]).map((item, index) => {
      if (item.status) {
        $('.edit_patents_orgs').append(`
          <div class="item_edit_patents_orgs">
            <b>${item.name}</b>
            <p>${item.description}.</p>
            <div class="switch_perm_orgs">
              <div class="on_orgs" onclick="setOfficePerm('${Object.keys(data[1])[index]}', this)"><img src="orgs/nui/images/on.svg" alt=""></div>
            </div>
          </div>
        `);
      }

      if (!item.status) {
        $('.edit_patents_orgs').append(`
          <div class="item_edit_patents_orgs">
            <b>${item.name}</b>
            <p>${item.description}.</p>
            <div class="switch_perm_orgs">
              <div class="off_orgs" onclick="setOfficePerm('${Object.keys(data[1])[index]}',this)"><img src="orgs/nui/images/off.svg" alt=""></div>
            </div>
          </div>
        `);
      }
    })

    $('.edit_patents_orgs').append(`
      <div class="content_button_confirm_patents_orgs">
        <div class="button_confirm_patents_orgs" onclick="confirmSaveOffices('${indexProp}')">
          SALVAR
        </div>
      </div>
    `);

    $('.item_patents_orgs0').addClass('selectOfficesOrgs')
  })
}
