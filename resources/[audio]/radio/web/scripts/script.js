var RadioChannel = "0.0";
var Emergency = false;
var Powered = true;

function closeGui () {
  if (Powered) {
    if (RadioChannel < 1.0 || RadioChannel > 799.9) {
      if (RadioChannel < 1 && Emergency) {
      } else {
        RadioChannel = "0.0";
      }
    }
    $.post("http://radio/close", JSON.stringify({ channel: RadioChannel }));
  } else {
    $.post("http://radio/cleanClose", JSON.stringify({}));
  }
}

function closeSave () {
  if (Powered) {
    RadioChannel = parseFloat($("#RadioChannel").val());
    if (!RadioChannel) {
      RadioChannel = "0.0";
    }
  }
  closeGui();
}

function changeVolume (element, { target }) {
  const value = target.value;
  const progress = (value / element.max) * 100;
  element.style.background = `linear-gradient(to right, white ${progress}%, white ${progress}%)`;
  $.post(
    "http://radio/volumeRadio",
    JSON.stringify({
      volume: $("#volume").val(),
    })
  );
}

function disconnect () {
  Powered = false;
  $.post("http://radio/click", JSON.stringify({}));
  $.post("http://radio/poweredOff", JSON.stringify({}));
  $("#RadioChannel").val("");
  $("#RadioChannel").attr("placeholder", "DIGITE SUA FREQUÊNCIA...");
  closeSave();
}

function connect () {
  Powered = true;
  $.post("http://radio/click", JSON.stringify({}));
  $.post("http://radio/poweredOn", JSON.stringify({ channel: $('#RadioChannel').val() }));
}

window.addEventListener("keyup", ({ key }) => {
  if (key === "Escape") closeSave();
})

window.addEventListener("message", function (event) {
  var item = event.data;
  if (item.reset === true) closeGui();
  if (item.set === true) RadioChannel = item.setChannel;
  if (item.open === true) {
    Emergency = item.jobType;
    if (RadioChannel != "0.0" && Powered) {
      $("#RadioChannel").val(RadioChannel);
    } else {
      if (Powered) {
        $("#RadioChannel").val("");
        $("#RadioChannel").attr("placeholder", "DIGITE SUA FREQUÊNCIA...");
      } else {
        $("#RadioChannel").val("");
        $("#RadioChannel").attr("placeholder", "DIGITE SUA FREQUÊNCIA...");
      }
    }
    $("#app").css('display', 'flex');
    $("#RadioChannel").focus();
  }
  if (item.open === false) $("#app").fadeOut(100);
});

document.querySelector('#RadioChannel').addEventListener('change', () => {
  Powered = true;
  $.post("http://radio/click", JSON.stringify({}));
  $.post("http://radio/poweredOn", JSON.stringify({ channel: $('#RadioChannel').val() }));
  closeSave();
})