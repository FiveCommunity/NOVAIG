var Radios = [document.getElementById("eoq")];
var Radios_volum = [1];
var estados = [true]
var index_user_id = [0];
var musicaatual = [1];
var linkmusic = null;
var lastmusic = null;
var user_id = null;
var volumeMusic = null;
var token = null;
var license = null;
var youtube_key = null;

$(document).ready(function() {
    window.addEventListener("message", function(event) {
        if (event.data.user_id) {
            user_id = event.data.user_id;
        }
        let data = event.data;
        switch (data.action) {
            case "openUI":
                $("body").fadeIn(200);
                break;

            case "closeUI":
                $("body").fadeOut(200);
                break;

            case "TimeVid":
                getTime(data.total, data.played);
                break;

            case "changetextv":
                setVolume(data.text)
                break;

            case "applyTokenAndLicense":
                token = data.token;
                license = data.license;
                youtube_key = data.youtube;
                break;

            case "changevidname":
                getNameFile(event.data.text);
                break;
        }
    });

    document.onkeyup = function(data) {
        if (data.which == 27) {
            $.post('https://ps_tify/action', JSON.stringify({
                action: 'exit'
            }));
        }
    };
});

$(document).on('click', '.general-options a', function(e) {
    e.preventDefault();

    var target = $(this).attr("data-target");

    if (target == "home") {
        $(".container .resultado").hide();
        $(".general-options .target-search").removeClass("active");
        $(this).addClass("active");
    } else if (target == "search") {
        $(".container .resultado").show();
        $(".general-options .target-home").removeClass("active");
        $(this).addClass("active");
    }
});

$(document).on('click', '.box-item', function(e) {
    var gender = $(this).attr("data-gender");

    searchGender(gender);
});

$(document).on('click', '.playlists a', function(e) {
    var gender = $(this).attr("data-gender");

    searchGender(gender);
});

$(document).on('click', '.song__button', function(e) {
    currentMusic(0);
    playMusic();
});

item = document.querySelectorAll(".playlist__item");
like = document.querySelectorAll(".song__like");
settings = document.querySelectorAll(".account__menu");
menu = document.querySelector("#account__settings");
search = document.querySelector("#song__input");
song = document.querySelectorAll(".song__title");
artist = document.querySelectorAll(".song__artist");

function active(event) {
    for (var i = 0; i < item.length; i++) {
        item[i].classList.remove("is-active");
    }
    this.classList.add("is-active");
}

function hideLike(event) {
    this.parentElement.classList.add("is-hide");
}

function sett(event) {
    menu.classList.toggle("is-x100");
    menu.classList.toggle("is-x0");
}

function filterSearch(event) {
    var content = search.value.toLowerCase();
    for (var i = 1; i < song.length; i++) {
        var title = song[i].innerHTML.toLowerCase();
        var art = artist[i].innerHTML.toLowerCase();
        if (title.match(content) || art.match(content)) {
            song[i].parentElement.style.display = "flex";
        } else {
            song[i].parentElement.style.display = "none";
        }
    }
}

function showHide(event) {
    var playlist = document.querySelector("#playlist");
    playlist.classList.toggle("playlist-show");
}

function main() {
    for (var i = 0; i < item.length; i++) {
        item[i].addEventListener("click", active);
    }
    for (var i = 0; i < song.length; i++) {
        like[i].addEventListener("click", hideLike);
    }
    settings[0].addEventListener("click", sett);
    search.addEventListener("keyup", filterSearch);


}

window.addEventListener("load", main);


/*
contact me on instagram if you found any bug on this player 
https://instagram.com/theviralboy.ig
some of the songs are not able to  play because codepen dosen't allow any non secure media links.
 */

// play and pause music
// contact me on instagram if you found any bug on this player 
// https://instagram.com/theviralboy.ig
// some of the songs are not able to  play because codepen dosen't allow any non secure media links.
//music info
const musicInfo = [];

// playlist
const playlist = document.querySelector(".playlist_list");


const bg = document.querySelector(".player__photo");
let musicName = document.querySelector(".player__song");
let artistName = document.querySelector(".player__artist");
let musicIndex = 0;
const currentMusic = (index) => {
    if (musicInfo.length > 0) {
        let i = index % musicInfo.length;
        bg.style.background = `url(${musicInfo[i].musicPoster}) center center no-repeat`;
        bg.style.backgroundSize = 'cover';
        musicName.innerText = musicInfo[i].musicName;
        artistName.innerText = musicInfo[i].artistName;
        id_video = musicInfo[i].musicSrc;
    }
};
currentMusic(musicIndex);

function getNameFile(url) {
    if (url == undefined) {
        bg.style.background = `transparent`;
        musicName.innerText = "";
        artistName.innerText = "";
        id_video = "";
    } else {
        $.getJSON('https://noembed.com/embed?url=', { format: 'json', url: url }, function(data) {
            if (data.thumbnail_url) {
                bg.style.background = `url(${data.thumbnail_url}) center center no-repeat`;
                bg.style.backgroundSize = 'cover';
            } else {
                bg.style.background = `transparent`;
            }

            if (data.title) {
                musicName.innerText = data.title;
            } else {
                musicName.innerText = "";
            }

            if (data.author_name) {
                artistName.innerText = data.author_name;
            } else {
                artistName.innerText = "";
            }

            var videoId = getYoutubeUrlId(url)
            if (videoId != "") {
                id_video = videoId;
            } else {
                id_video = "";
            }
        });
    }
}

// music controls
const prevBtn = document.querySelector(".player_anterior");
const playBtn = document.querySelector(".player_play");
const nextBtn = document.querySelector(".player_proximo");
const loopBtn = document.querySelector(".player_loop");
const shuffleBtn = document.querySelector(".player_random");
let isPlaying = false;
let isShuffle = false;
let isLoop = false;

playBtn.onclick = () => {
    startMusic();
};
const startMusic = () => {
    isPlaying ? pauseMusic() : playMusic();
};
loopBtn.onclick = () => {
    $.post('https://ps_tify/action', JSON.stringify({
        action: 'loop'
    }));
    isLoop = !isLoop;
    if (isLoop == true) {
        loopBtn.classList.add("active");
    } else {
        loopBtn.classList.remove("active");
    }
};
shuffleBtn.onclick = () => {
    isShuffle = !isShuffle;
    if (isShuffle == true) {
        shuffleBtn.classList.add("active");
    } else {
        shuffleBtn.classList.remove("active");
    }
};

nextBtn.onclick = () => {
    nextMusic();
};
const nextMusic = () => {
    musicIndex = musicIndex + 1;
    currentMusic(musicIndex);
    playMusic();
};
prevBtn.onclick = () => {
    prevMusic();
};
const prevMusic = () => {
    musicIndex = musicIndex - 1;
    currentMusic(musicIndex);
    playMusic();
};

const playMusic = () => {
    isPlaying = true;

    var url = `https://www.youtube.com/watch?v=${id_video}`;

    $.post('https://ps_tify/action', JSON.stringify({
        action: 'seturl',
        link: url,
    }));

    playBtn.src = "./img/pause.svg";
};

function pauseMusic() {
    isPlaying = false;

    $.post('https://ps_tify/action', JSON.stringify({
        action: 'pause'
    }));

    playBtn.src = "./img/play.svg";
}

// music time
const duration = document.querySelector(".player__time_duration");
if (duration.innerText == "NaN:0NaN") {
    duration.innerText = "0:00 - 0:00";
}

function getTime(totaltime, timeplayed) {
    if (totaltime != undefined && timeplayed != undefined) {
        if (secondsToHms(timeplayed) > secondsToHms(totaltime)) {
            timeplayed = timeplayed - 1
        }
        duration.innerText = secondsToHms(timeplayed) + " - " + secondsToHms(totaltime);

        const timebar = document.querySelector(".player__time_bar");
        timebar.style.width = (timeplayed / totaltime) * 100 + "%";
    } else {
        duration.innerText = "0:00 - 0:00";
    }
}

function setVolume(width) {
    $(".player__volume_bar").width(width);
}

function secondsToHms(d) {
    d = Number(d);
    var h = Math.floor(d / 3600);
    var m = Math.floor(d % 3600 / 60);
    var s = Math.floor(d % 3600 % 60);

    var hDisplay = h > 0 ? h + ":" : "";
    var mDisplay = m > 0 ? m + ":" : "0:";
    var sDisplay = "00"
    if (s > 0) {
        sDisplay = s
        if (s < 10) {
            sDisplay = "0" + s
        }
    }
    return (hDisplay + mDisplay + sDisplay);
}

function arredondaDezena(num) {
    return Math.ceil(num / 10) * 10;
}

const volumeTimebar = document.querySelector(".player__volume");
volumeTimebar.addEventListener("click", (e) => {
    let a = e.offsetX;
    const b = e.srcElement.clientWidth;

    var widthatual = $(".player__volume_bar").width();
    widthatual = arredondaDezena(widthatual);
    var width = 0;

    if (a <= 10) {
        width = widthatual - 10;
        $(".player__volume_bar").width(width);

        $.post('https://ps_tify/action', JSON.stringify({
            action: 'volumedown'
        }));

    } else if (a >= 60) {
        width = widthatual + 10;

        if (width > b) {
            width = b;
        }
        $(".player__volume_bar").width(width);

        $.post('https://ps_tify/action', JSON.stringify({
            action: 'volumeup'
        }));
    }
});


function searchGender(gender) {

    while (musicInfo.length > 0) {
        musicInfo.splice(0, musicInfo.length);
    }

    makeRequest(gender);

    var checkopen = $('.container .resultado').is(':visible');
    if (!checkopen) {
        $(".container .resultado").show();
        $(".general-options .target-home").removeClass("active");
        $(".general-options .target-search").addClass("active");
    }

}

const searchMusics = () => {

    while (musicInfo.length > 0) {
        musicInfo.splice(0, musicInfo.length);
    }

    var query = $(".account__input").val();

    makeRequest(query);

}

function makeRequest(query) {

    if (query.length > 0) {

        $(".container #search").show();
        $(".container #error").hide();
        $(".container #song").hide();

        var formdata = new FormData();
        formdata.append("query", query);
        formdata.append("max", 50);
        formdata.append("youtube_key", youtube_key);

        var url = `http://${IP}/history.json`;

        $.ajax({
            type: "POST",
            url: url,
            data: formdata,
            cache: false,
            contentType: false,
            processData: false,
            success: function(response) {
                if (response.error == false) {

                    $.each(response.data.musics, function(index, item) {
                        var data = {
                            musicName: item.title,
                            artistName: item.author,
                            musicSrc: item.id,
                            musicPoster: item.image,
                        }

                        musicInfo.push(data);
                    });

                    musicInfoAdd();
                    $(".container #search").hide();
                    $(".container #error").hide();
                    $(".container #song").show();
                } else {
                    return false;
                }
            },
            error: function(result) {
                $(".container #search").hide();
                $(".container #error").show();
                $(".container #song").hide();
            }
        });

        $(".search input").val("");
    }

}

function musicInfoAdd(params) {
    $(".playlist_list").html("");
    musicInfo.forEach((item, index) => {

        var html = `<div class="song__item"><img class="song__like" src="${item.musicPoster}" alt="Foto">
            <div class="song__title">${item.musicName}</div>
            <div class="song__artist">${item.artistName}</div>
        </div>`;

        $(".playlist_list").append(html);
    });

    const playlistItems = document.querySelectorAll(".song__item");
    playlistItems.forEach((item, index) => {
        if (index != 0) {
            index = index - 1;
            item.onclick = () => {
                currentMusic(index);
                playMusic();
            };
        } else {
            item.onclick = () => {
                currentMusic(0);
                playMusic();
            };
        }
    });
}

window.addEventListener("keydown", (e) => {
    let code = e.keyCode;
    if (code == 38) {
        var widthatual = $(".player__volume_bar").width();
        widthatual = arredondaDezena(widthatual);
        var width = 0;
        width = widthatual + 10;
        if (width < 101) {
            $(".player__volume_bar").width(width);
        }

        $.post('https://ps_tify/action', JSON.stringify({
            action: 'volumeup'
        }));
    }
    if (code == 40) {
        var widthatual = $(".player__volume_bar").width();
        widthatual = arredondaDezena(widthatual);
        var width = 0;
        width = widthatual - 10;
        $.post('https://ps_tify/action', JSON.stringify({
            action: 'volumedown'
        }));
    }
    if (code == 13) {
        searchMusics();
    }
});

$(document).on('click', '#error_show .close', function(e) {
    $("#error_show").fadeOut();
});


function formatTime(time) {
    time = Math.round(time);

    var minutes = Math.floor(time / 60),
        seconds = time - minutes * 60;

    seconds = seconds < 10 ? '0' + seconds : seconds;

    return minutes + ":" + seconds;
}

function getYoutubeUrlId(url) {
    var videoId = "";
    if (url.indexOf("youtube") !== -1) {
        var urlParts = url.split("?v=");
        videoId = urlParts[1].substring(0, 11);
    }

    if (url.indexOf("youtu.be") !== -1) {
        var urlParts = url.replace("//", "").split("/");
        videoId = urlParts[1].substring(0, 11);
    }
    return videoId;
}