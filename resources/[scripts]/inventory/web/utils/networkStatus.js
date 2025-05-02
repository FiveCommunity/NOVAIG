window.isOnline = true;

window.addEventListener("online", () => {
	window.isOnline = true;
	$("#root").removeClass("offline");
});

window.addEventListener("offline", () => {
	window.isOnline = false;
	$("#root").addClass("offline");
});
