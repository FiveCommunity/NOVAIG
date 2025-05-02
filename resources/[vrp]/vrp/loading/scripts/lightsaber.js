var playlist = [
	{
		"image"   : "https://brasil.lotusgroup.dev/_assets/mae-solteira.png",
		"song"    : "MÃE SOLTEIRA - J.Eskine",
		"album"   : "BRASIL",
		"artist"  : "BRASIL",
		"mp3"     : "https://brasil.lotusgroup.dev/_assets/mae-solteira.mp3"
	},
];

var rot = 0;
var duration;
var playPercent;
var bufferPercent;
var currentSong = Math.round(Math.random() * (playlist.length - 1));
var arm_rotate_timer;
var arm = document.getElementById("arm");
var next = document.getElementById("next");
var song = document.getElementById("song");
var timer = document.getElementById("timer");
var music = document.getElementById("music");
// var music = new Audio(playlist[currentSong].mp3);
var volume = document.getElementById("volume");
var playButton = document.getElementById("play");
var timeline = document.getElementById("slider");
var playhead = document.getElementById("elapsed");
var previous = document.getElementById("previous");
var pauseButton = document.getElementById("pause");
var bufferhead = document.getElementById("buffered");
var timelineWidth = timeline.offsetWidth - playhead.offsetWidth;
var visablevolume = document.getElementsByClassName("volume")[0];

music.addEventListener("ended", _next, false);
music.addEventListener("timeupdate", ({ target }) => {
	if (target.duration) {
		playPercent = timelineWidth * (target.currentTime / target.duration);
		playhead.style.width = playPercent + "px";
		timer.innerHTML = formatSecondsAsTime(music.currentTime.toString());
	}
}, false);

window.addEventListener('DOMContentLoaded', () => load())
// load();

function load(){
	pauseButton.style.display = "none";
	song.innerHTML = playlist[currentSong]['song'];
	song.title = playlist[currentSong]['song'];
	music.volume = 0.2;
	music.innerHTML = '<source src="'+playlist[currentSong]['mp3']+'" type="audio/mp3">';
  document.querySelector('.image').style.backgroundImage = `url(${playlist[currentSong]['image']})`
	music.load();
	setTimeout(() => {
		playButton.style.display = "none";
	  pauseButton.style.display = "block";
    music.play()
  }, 3000)
}

function reset(){ 
	rotate_reset = setInterval(function(){
		if(rot == 0){
			clearTimeout(rotate_reset);
		}
	}, 1);
	fireEvent(pauseButton, 'click');
	playhead.style.width = "0px";
	// bufferhead.style.width = "0px";
	timer.innerHTML = "0:00";
	music.innerHTML = "";
	currentSong = 0;
	song.innerHTML = playlist[currentSong]['song'];
	song.title = playlist[currentSong]['song'];
	music.innerHTML = '<source src="'+playlist[currentSong].mp3+'" type="audio/mp3">';
	document.querySelector('.image').style.backgroundImage = `url(${playlist[currentSong].image})`
	music.load();
}

function formatSecondsAsTime(secs, format) {
  var hr  = Math.floor(secs / 3600);
  var min = Math.floor((secs - (hr * 3600))/60);
  var sec = Math.floor(secs - (hr * 3600) -  (min * 60));
  if (sec < 10){ 
    sec  = "0" + sec;
  }
  return min + ':' + sec;
}

function fireEvent(el, etype){
	if (el.fireEvent) {
		el.fireEvent('on' + etype);
	} else {
		var evObj = document.createEvent('Events');
		evObj.initEvent(etype, true, false);
		el.dispatchEvent(evObj);
	}
}

function _next(){
	if(currentSong == playlist.length - 1){
		reset();
	} else {
		fireEvent(next, 'click');
	}
}

playButton.onclick = function() {
	music.play();
}

pauseButton.onclick = function() {
	music.pause();
}

music.addEventListener("play", function () {
	playButton.style.display = "none";
	pauseButton.style.display = "block";
	// rotate_timer = setInterval(function(){ 
	// 	if(!music.paused && !music.ended && 0 < music.currentTime){
			
	// 	}
	// }, 10);	
	// arm_rotate_timer = setInterval(function(){ 
	// 	if(!music.paused && !music.ended && 0 < music.currentTime){
	// 		if(arm.style.transition != ""){
	// 			setTimeout(function(){
	// 				arm.style.transition = "";
	// 			}, 1000);
	// 		}
	// 	}
	// }, 1000);
}, false);

music.addEventListener("pause", function () {
	pauseButton.style.display = "none";
	playButton.style.display = "block";
	// clearTimeout(rotate_timer);
	// clearTimeout(arm_rotate_timer);
}, false);

next.onclick = function(){
	// arm.setAttribute("style", "transition: transform 800ms;");
	// arm.style.transform = 'rotate(-45deg)';
	// clearTimeout(rotate_timer);
	// clearTimeout(arm_rotate_timer);
	playhead.style.width = "0px";
	// bufferhead.style.width = "0px";
	timer.innerHTML = "0:00";
	music.innerHTML = "";
	// arm.style.transform = 'rotate(-45deg)';
	// armrot = -45;
	if((currentSong + 1) == playlist.length){
		currentSong = 0;
		music.innerHTML = '<source src="'+playlist[currentSong]['mp3']+'" type="audio/mp3">';
	} else {
		currentSong++;
		music.innerHTML = '<source src="'+playlist[currentSong]['mp3']+'" type="audio/mp3">';
	}
	document.querySelector('.image').style.backgroundImage = `url(${playlist[currentSong].image})`
	song.innerHTML = playlist[currentSong]['song'];
	song.title = playlist[currentSong]['song'];
	music.load();
	duration = music.duration;
	music.play();
}

previous.onclick = function(){
	// arm.setAttribute("style", "transition: transform 800ms;");
	// arm.style.transform = 'rotate(-45deg)';
	// clearTimeout(rotate_timer);
	// clearTimeout(arm_rotate_timer);
	playhead.style.width = "0px";
	// bufferhead.style.width = "0px";
	timer.innerHTML = "0:00";
	music.innerHTML = "";
	// arm.style.transform = 'rotate(-45deg)';
	// armrot = -45;
	if((currentSong - 1) == -1){
		currentSong = playlist.length - 1;
		music.innerHTML = '<source src="'+playlist[currentSong]['mp3']+'" type="audio/mp3">';
	} else {
		currentSong--;
		music.innerHTML = '<source src="'+playlist[currentSong]['mp3']+'" type="audio/mp3">';
	}
	document.querySelector('.image').style.backgroundImage = `url(${playlist[currentSong].image})`
	song.innerHTML = playlist[currentSong]['song'];
	song.title = playlist[currentSong]['song'];
	music.load();
	duration = music.duration;
	music.play();
}

volume.oninput = function(){
	music.volume = volume.value;
	// visablevolume.style.width = (80 - 11) * volume.value + "px";
}

music.addEventListener("canplay", function () {
	duration = music.duration;
}, false);

// const bd = document.body, cur = document.getElementById("fare");
// bd.addEventListener("mousemove", function(n) {
//     (cur.style.left = n.clientX + "px"), (cur.style.top = n.clientY + "px")
// })
