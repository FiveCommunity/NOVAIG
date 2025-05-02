$(document).ready(function () {
  $.post("http://vrp_creator/loadUi");
});

$("body").on("click", ".left .categories button", function (event) {
  $(".left .categories button").each(function () {
    $(this).removeClass("selected");
  });
  $(".left .options .subCategory").each(function () {
    $(this).stop().fadeOut(250);
  });
  let menu = $(this).attr("data-menu");
  $(this).addClass("selected");

  setTimeout(function () {
    $("#" + menu)
      .stop()
      .fadeIn(250);
  }, 300);
});

$("body").on("click", ".right .categories button", function (event) {
  $(".right .categories button").each(function () {
    $(this).removeClass("selected");
  });
  $(".right .options .subCategory").each(function () {
    $(this).stop().fadeOut(250);
  });
  let menu = $(this).attr("data-menu");
  $(this).addClass("selected");

  setTimeout(function () {
    $("#" + menu)
      .stop()
      .fadeIn(250);
  }, 300);
});

const app = new Vue({
  el: "#app",
  data: {
    CharacterMode: false,
    idNome: "",
    idSobrenome: "",
    idIdade: 0,
    gender: 0,
    father: 0,
    mother: 0,
    fathersID: [
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18,
      19, 20, 42, 43, 44,
    ],
    fathers: [
      "Benjamin",
      "Daniel",
      "Joshua",
      "Noah",
      "Andrew",
      "Joan",
      "Alex",
      "Isaac",
      "Evan",
      "Ethan",
      "Vincent",
      "Angel",
      "Diego",
      "Adrian",
      "Gabriel",
      "Michael",
      "Santiago",
      "Kevin",
      "Louis",
      "Samuel",
      "Anthony",
      "John",
      "Niko",
      "Claude",
    ],
    mothersID: [
      21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37,
      38, 39, 40, 41, 45,
    ],
    mothers: [
      "Hannah",
      "Audrey",
      "Jasmine",
      "Giselle",
      "Amelia",
      "Isabella",
      "Zoe",
      "Ava",
      "Camilla",
      "Violet",
      "Sophia",
      "Eveline",
      "Nicole",
      "Ashley",
      "Grace",
      "Brianna",
      "Natalie",
      "Olivia",
      "Elizabeth",
      "Charlotte",
      "Emma",
      "Misty",
    ],
    skinColor: 6,
    shapeMix: 0.5,
    camRotation: 180,

    eyesColor: 0,
    eyebrowsHeight: 0.0,
    eyebrowsWidth: 0.0,
    noseWidth: 0.0,
    noseHeight: 0.0,
    noseLength: 0.0,
    noseBridge: 0.0,
    noseTip: 0.0,
    noseShift: 0.0,
    cheekboneHeight: 0.0,
    cheekboneWidth: 0.0,
    cheeksWidth: 0.0,
    lips: 0.0,
    jawWidth: 0.0,
    jawHeight: 0.0,
    chinLength: 0.0,
    chinPosition: 0.0,
    chinWidth: 0.0,
    chinShape: 0.0,
    neckWidth: 0.0,

    hairModel: 4,
    firstHairColor: 0,
    secondHairColor: 0,
    eyebrowsModel: 0,
    eyebrowsColor: 0,
    beardModel: -1,
    beardColor: 0,
    chestModel: -1,
    chestColor: 0,
    blushModel: -1,
    blushColor: 0,
    lipstickModel: -1,
    lipstickColor: 0,
    blemishesModel: -1,
    ageingModel: -1,
    complexionModel: -1,
    sundamageModel: -1,
    frecklesModel: -1,
    makeupModel: -1,
  },
  methods: {
    OpenCharacterMode: function () {
      this.CharacterMode = true;
      $("body").addClass("appbackground");
    },
    CloseCharacterMode: function () {
      this.CharacterMode = false;
      $("body").removeClass("appbackground");
    },
    changeAppearance: function () {
      const arr1 = {
        idNome: this.idNome.trim(),
        idSobrenome: this.idSobrenome.trim(),
        idIdade: this.idIdade,
        fathersID: this.fathersID[this.father],
        mothersID: this.mothersID[this.mother],
        skinColor: this.skinColor,
        shapeMix: this.shapeMix,
      };
      $.post(
        "http://vrp_creator/UpdateSkinOptions",
        JSON.stringify(arr1)
      );

      const arr2 = {
        eyesColor: this.eyesColor,

        eyebrowsHeight: this.eyebrowsHeight,
        eyebrowsWidth: this.eyebrowsWidth,

        noseWidth: this.noseWidth,
        noseHeight: this.noseHeight,
        noseLength: this.noseLength,
        noseBridge: this.noseBridge,
        noseTip: this.noseTip,
        noseShift: this.noseShift,

        cheekboneHeight: this.cheekboneHeight,
        cheekboneWidth: this.cheekboneWidth,
        cheeksWidth: this.cheeksWidth,
        lips: this.lips,
        jawWidth: this.jawWidth,
        jawHeight: this.jawHeight,
        chinLength: this.chinLength,
        chinPosition: this.chinPosition,
        chinWidth: this.chinWidth,
        chinShape: this.chinShape,
        neckWidth: this.neckWidth,
      };
      $.post(
        "http://vrp_creator/UpdateFaceOptions",
        JSON.stringify(arr2)
      );

      const arr3 = {
        hairModel: this.hairModel,
        firstHairColor: this.firstHairColor,
        secondHairColor: this.secondHairColor,
        eyebrowsModel: this.eyebrowsModel,
        eyebrowsColor: this.eyebrowsColor,
        beardModel: this.beardModel,
        beardColor: this.beardColor,
        chestModel: this.chestModel,
        chestColor: this.chestColor,
        blushModel: this.blushModel,
        blushColor: this.blushColor,
        lipstickModel: this.lipstickModel,
        lipstickColor: this.lipstickColor,
        blemishesModel: this.blemishesModel,
        ageingModel: this.ageingModel,
        complexionModel: this.complexionModel,
        sundamageModel: this.sundamageModel,
        frecklesModel: this.frecklesModel,
        makeupModel: this.makeupModel,
        makeupColor: this.makeupColor,
      };

      $.post(
        "http://vrp_creator/UpdateHeadOptions",
        JSON.stringify(arr3)
      );
    },
    changeGender: function (newGender) {
      this.gender = newGender;
      $.post(
        "http://vrp_creator/ChangeGender",
        JSON.stringify({ gender: this.gender })
      );
      this.changeAppearance();
    },
    changeCamRotation: function () {
      $.post(
        "http://vrp_creator/cChangeHeading",
        JSON.stringify({ camRotation: this.camRotation })
      );
    },
    done: function () {
      app.changeAppearance();

      const arr = [
        this.idNome.trim(),
        this.idSobrenome.trim(),
        this.idIdade,
        this.fathersID[this.father],
        this.mothersID[this.mother],
        this.skinColor,
        this.shapeMix,
      ];
      $.post("http://vrp_creator/cDoneSave");
    },
  },
});

app.changeAppearance();