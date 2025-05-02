class Weapons {
	weapons;
	selected;
	constructor(weapons) {
		this.weapons = weapons;
		this.renderWeapons();
	}
	async manageWeapons(type = "selected") {
		if (!globalThis.isOnline) {
			Notify("Sem conexão com a internet!", "error");
			return;
		}
		if (type === "selected") {
			const response = await Client("MANAGE_WEAPONS", {
				weapons: [this.selected],
			});
			if (!response || response?.error) {
				Notify(response?.error || "Erro", "error");
				return;
			}
			if (response.success) {
				delete this.weapons[this.selected];
				this.renderWeapons();
				window.classInstances.left = new Inventory(
					await Client("GET_INVENTORY"),
				);
			}
		} else if (type === "all") {
			const response = await Client("MANAGE_WEAPONS", {
				weapons: Object.keys(this.weapons),
			});
			if (!response || response?.error) {
				Notify(response?.error || "Erro", "error");
				return;
			}
			if (response.success) {
				this.weapons = {};
				this.renderWeapons();
				window.classInstances.left = new Inventory(
					await Client("GET_INVENTORY"),
				);
			}
		}
	}
	renderWeapons() {
		document.querySelector("#right").style.display = "none";
		// for (const el of document.querySelectorAll(".onlyInventory")) {
		// 	el.style.display = "block";
		// }
		$(".weapons-container").empty();
		Object.keys(this.weapons).forEach((weapon) => {
			if (!weapon.includes("PARACHUTE")) {
				const weaponConfig = {};
				const weaponName = weapon.toLowerCase();
				if (globalThis.Config[weaponName]) {
					weaponConfig.name = globalThis.Config[weaponName].name;
				}
				const weaponElement = $(`
					<div class="weapon" style="background-image: url('${window.imageUrl}/${weaponName}.png');"></div>
				`);
				$(".weapons-container").append(weaponElement);
			}
		});
	}
}
$(document).on("click", ".slot-weapon", function () {
	$(".selected-weapon").removeClass("selected-weapon");
	$(this).addClass("selected-weapon");
	window.classInstances.weapons.selected = $(this).data("weapon");
});

$(document).on("dblclick", ".slot-weapon", () => {
	window.classInstances.weapons.manageWeapons("selected");
});

$(".button-left-red").on("click", async () =>
	window.classInstances.weapons.manageWeapons("selected"),
);
$(".button-left-black").on("click", async () =>
	window.classInstances.weapons.manageWeapons("all"),
);
