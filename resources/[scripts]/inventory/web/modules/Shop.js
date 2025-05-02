class Shop extends Inventory {
	mode;
	store_name;
	constructor(data, side = "right") {
		super(data, side);
		const { store_name, mode } = data;
		this.mode = mode;
		this.store_name = store_name;
		// $(".chest-title").text(store_name);

		// document.querySelector('.items-container').style.maxHeight = '65.275rem'
		document.querySelector("#right").style.display = "block";
	}

	async takeItem(from_slot, amount, to_slot) {
		amount = Number(amount) || 0;
		if (this.mode !== "buy") {
			Notify("Essa loja permite apenas venda!");
			return false;
		}
		if (typeof from_slot === "number") from_slot = from_slot.toString();
		if (typeof to_slot === "number") to_slot = to_slot.toString();
		const invInstance = window.classInstances.left;

		if (invInstance.items[to_slot]) {
			if (invInstance.items[to_slot].item === this.items[from_slot].item) {
				const response = await Client("SHOP_ACTION", {
					slot: to_slot,
					store_name: this.store_name,
					amount,
					item: this.items[from_slot].item,
				});
				if (response.error) {
					invInstance.renderSlots("left");
					this.renderSlots("right");
					Notify(response.error, "error");
					return false;
				}
				if (response.notify) {
					Notify(response.notify, "success");
				}
				invInstance.items[to_slot].amount += amount;
				invInstance.renderSlots("left");
				this.renderSlots("right");
				return true;
			}
			Notify(
				"Arraste o item para o slot vazio ou que contenha o mesmo item à ser comprado",
				"error",
			);
			return;
		}
		const response = await Client("SHOP_ACTION", {
			slot: to_slot,
			store_name: this.store_name,
			amount,
			item: this.items[from_slot].item,
		});
		if (response.error) {
			invInstance.renderSlots("left");
			this.renderSlots("right");
			Notify(response.error, "error");
			return false;
		}
		if (response.money) {
			let moneyCount = response.money;
			const slotsParsed = [];
			while (moneyCount > 0) {
				const _slot = invInstance.findSlotByItem(
					"money",
					slotsParsed.length > 0 ? slotsParsed : 0,
				);
				if (!_slot) {
					break;
				}
				
				if (invInstance.items[_slot].amount) {
					if (moneyCount > invInstance.items[_slot].amount) {
						moneyCount -= invInstance.items[_slot].amount;
						invInstance.removeItem(_slot, invInstance.items[_slot].amount);
					} else {
						invInstance.removeItem(_slot, moneyCount);
						slotsParsed.push(_slot);
						moneyCount = 0;
					}
				}
			}
		}
		if (response.notify) {
			Notify(response.notify, "success");
		}

		invInstance.items[to_slot] = JSON.parse(
			JSON.stringify(this.items[from_slot]),
		);
		invInstance.items[to_slot].amount = amount;
		invInstance.items[to_slot].price = undefined;
		invInstance.renderSlots("left");
		this.renderSlots("right");
		return true;
	}
	async putItem(from_slot, amount, to_slot) {
		if (this.mode !== "sell") {
			Notify("Essa loja permite apenas compra!");
			return false;
		}

		if (typeof from_slot === "number") from_slot = from_slot.toString();
		if (typeof to_slot === "number") to_slot = to_slot.toString();
		const invInstance = window.classInstances.left;
		amount =
			amount > invInstance.items[from_slot].amount || amount <= 0
				? invInstance.items[from_slot].amount
				: amount;

		if (invInstance.items[from_slot] && this.items[to_slot]) {
			if (invInstance.items[from_slot].item === this.items[to_slot].item) {
				const response = await Client("SHOP_ACTION", {
					slot: from_slot,
					store_name: this.store_name,
					amount,
					item: this.items[to_slot].item,
				});
				if (response.error) {
					Notify(response.error, "error");
					invInstance.renderSlots("left");
					this.renderSlots("right");
					return false;
				}
				if (response.money) {
					const foundSlot = invInstance.findSlotByItem("money");
					if (foundSlot) {
						invInstance.items[foundSlot].amount += response.money;
					}
				}
				if (response.notify) {
					Notify(response.notify, "success");
				}
				invInstance.items[from_slot].amount -= amount;
				if (invInstance.items[from_slot].amount <= 0) {
					delete invInstance.items[from_slot];
				}
				this.renderSlots("right");
				invInstance.renderSlots("left");
				return true;
			}
			Notify(
				"Arraste o item para o slot que contenha o mesmo item à ser vendido",
				"error",
			);
			return;
		}

		if (invInstance.items[from_slot] && !this.items[to_slot]) {
			Notify(
				"Arraste o item para o slot que contenha o mesmo item à ser vendido",
				"error",
			);
			return;
		}

		invInstance.renderSlots("left");
		this.renderSlots("right");
		return false;
	}
}
