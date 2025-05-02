window.classInstances = {};
globalThis.SelectedItem = {};
window.imageUrl = 'http://177.54.148.31:4020/lotus/inventario_tokyo'

window.isOnline = true;

window.addEventListener("online", () => {
	window.isOnline = true;
	$("#inventory").removeClass("offline");
});

window.addEventListener("offline", () => {
	window.isOnline = false;
	$("#inventory").addClass("offline");
});

const Routes = {
	OPEN_INVENTORY: async (payload) => {
		const userInventory = await Client("GET_INVENTORY");
		window.classInstances.weapons = new Weapons(await Client("GET_WEAPONS"));
		window.classInstances.left = new Inventory(userInventory);
		const pickupData = await Client("GET_PICKUPS");
		if(pickupData.inventory && Object.keys(pickupData.inventory).length > 0){
			window.classInstances.right = new Pickup(pickupData);
		}else{
			$(".left-main").css("display", "flex");
			for (const el of document.querySelectorAll(".onlyInventory")) {
				el.style.display = "flex";
			}
		}
		$("#inventory").show();
		document.querySelector('.chest-title').innerHTML = 'Chão'
	},
	UPDATE_PICKUP: async (payload) => {
		if (window.classInstances?.right?.pickup) {
			const pickupData = await Client("GET_PICKUPS");
			window.classInstances.right = new Pickup(pickupData);
		}
	},
	OPEN_CHEST: async (payload) => {
		$(".left-main").css("display", "none");
		const userInventory = await Client("GET_INVENTORY");
		window.classInstances.left = new Inventory(userInventory);
		window.classInstances.right = new Chest(payload);
		document.querySelector('.chest-title').innerHTML = 'Báu'
		$("#inventory").show();
	},
	CLOSE_INVENTORY: async (payload) => {
		const ignoreRight = payload.ignoreRight || false;
		Client("CLOSE_INVENTORY", {
			right: ignoreRight || (window.classInstances.hasOwnProperty("right") && !window.classInstances?.right?.pickup),
		});
		window.classInstances = {};
		$(".left-main").css("display", "none");
		$(".add-main").css("display", "none");

		$("#inventory").hide();
	},
	OPEN_INSPECT: async (payload) => {
		$(".left-main").css("display", "none");
		window.classInstances.left = new Inventory(payload.source);
		window.classInstances.right = new Inspect(payload.target);
		$("#inventory").show();
		document.querySelector('.chest-title').innerHTML = 'Revista'
	},
	OPEN_SHOP: async (payload) => {
		$(".left-main").css("display", "none");
		const userInventory = await Client("GET_INVENTORY");
		window.classInstances.left = new Inventory(userInventory);
		window.classInstances.right = new Shop(payload);
		$("#inventory").show();
		$('.weight-wrapper-right').css('display', 'none')
		document.querySelector('.chest-title').innerHTML = 'Loja de departamento'
	},
	FORCE_UPDATE_INVENTORY: async (payload) => {
		if (window.classInstances.left && $("#inventory").is(":visible")) {
			const userInventory = await Client("GET_INVENTORY");
			window.classInstances.left = new Inventory(userInventory);
		}
	},
};

$(() => {
	window.addEventListener("message", async ({ data }) => {
		const { route, payload = {} } = data;
		if (!globalThis.Config) {
			globalThis.Config = await Client("REQUEST_ITEMS_CONFIG");
		}
		if (Routes[route]) {
			try {
				await Routes[route](payload);
			} catch (err) {
				
				
			}
		}
	});

	document.addEventListener("keydown", ({ key }) => {
		if (key === "Escape") {
			Client("CLOSE_INVENTORY", {
				right: window.classInstances.hasOwnProperty("right"),
			});
			window.classInstances = {};
			$('.weight-wrapper-right').css('display', 'block')
			$(".left-main").css("display", "none");
			$(".add-main").css("display", "none");

			$("#inventory").hide();
		}
	});
});

function Close() {
	Client("CLOSE_INVENTORY", {
		right: window.classInstances.hasOwnProperty("right"),
	});
	$('.weight-wrapper-right').css('display', 'block')
	window.classInstances = {};
	$(".left-main").css("display", "none");
	$(".add-main").css("display", "none");

	$("#inventory").hide();
}

$(".action-button").click(async function () {
	if (!globalThis.isOnline) {
		Notify("Sem conexão com a internet!", "error");
		return;
	}

	if (!globalThis.SelectedItem || globalThis.SelectedItem.side !== "left")
		return Notify("Selecione um item do seu inventário primeiro!", "error");
	let { item, id } = globalThis.SelectedItem;
	if (!window.classInstances.left.items[id]) {
		id = window.classInstances.left.findSlotByItem(item);
		if (!id)
			return Notify("Selecione um item do seu inventário primeiro!", "error");
	}
	let inputValue =
		Number.parseInt($(".input-frame").val()) > 0
			? Number.parseInt($(".input-frame").val())
			: globalThis.SelectedItem.amount;
	inputValue =
		inputValue > globalThis.SelectedItem.amount
			? globalThis.SelectedItem.amount
			: inputValue;

	const action = $(this).data("route");

	const response = await Client(action, {
		slot: id,
		item: item,
		amount: inputValue,
	});
	if (typeof response !== "boolean" && response?.error) {
		Notify(response.error, "error");
		return;
	}
	if (!response) {
		return;
	}
	if (response) {
		window.classInstances.left.removeItem(
			id,
			response?.used_amount || inputValue,
		);
		if (
			action === "USE_ITEM" &&
			(globalThis.Config[item]?.type === "equip" ||
				globalThis.Config[item]?.type === "recharge")
		) {
			window.classInstances.weapons = new Weapons(await Client("GET_WEAPONS"));
		}
	}
});

$(document).on("click", ".slot-left", function () {
	window.classInstances.left.selectItem("left", $(this).data("id"));
});

$(document).on("click", ".slot-right", function () {
	window.classInstances.right.selectItem("right", $(this).data("id"));
});

async function Client(route, body = {}) {
	const res = await fetch(`http://${window.GetParentResourceName()}/${route}`, {
		method: "POST",
		headers: {
			"Content-type": "application/json; charset=UTF-8",
		},
		body: JSON.stringify(body),
	});

	const response = await res.json();
	if (route === "USE_ITEM" && !window.classInstances.left) return false;
	return response;
}

const NotifysType = {
	error: "linear-gradient(to right, #ff3737c7, #b02020c7)",
	success: "linear-gradient(to right, #56ab2f, #a8e063)",
}

function Notify(text, type) {
	Client("PLAY_SOUND", { sound: type });
	Toastify({
		text: text,
		className: type,
		duration: 3000,
		style: {
			"font-family": "Roboto Condensed",
			"font-weight": "350",
			background:
				NotifysType[type] || "linear-gradient(to right, #414d0b, #727a17)",
		},
	}).showToast();
}

function openStore() {
	fetch('https://inventory/openStore', { method: 'POST' })
}

if (!window.invokeNative) {
	document.querySelector("#inventory").style.display = 'block'
	$(".slot").droppable({
		accept: ".slot-item",
		drop: async (event, ui) => {
			const self = window.classInstances[ui.draggable.data("side")];
			if (!self) return;
			const id = ui.draggable.data("id");
			await self.changeItemPos(
				{ side: ui.draggable.data("side"), id },
				{ side: event.target.dataset.side, id: event.target.dataset.id },
				event.ctrlKey
					? "ctrl"
					: event.ctrlKey || event.shiftKey
						? "shift"
						: event.shiftKey,
			);
			if (ui.draggable.data("side") !== event.target.dataset.side) {
				window.classInstances[event.target.dataset.side].selectItem(
					event.target.dataset.side,
					event.target.dataset.id,
				);
			} else {
				self.selectItem(event.target.dataset.side, event.target.dataset.id);
			}
		},
	});
}

if (!window.invokeNative) {
	document.querySelector('.profile-wrapper').style.display = 'flex'
}
