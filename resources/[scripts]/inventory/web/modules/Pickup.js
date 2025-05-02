class Pickup extends Inventory {
    pickup;
	constructor(data, side = "right") {
        super(data, side, true);
        this.pickup = true;
		// $(".chest-title").text('Chão');

		// document.querySelector('.items-container').style.maxHeight = '65.275rem'
		document.querySelector("#right").style.display = "block";
	}
	async takeItem(from_slot, amount, to_slot) {
		if (typeof from_slot === "number") from_slot = from_slot.toString();
		if (typeof to_slot === "number") to_slot = to_slot.toString();
		const invInstance = window.classInstances.left;
		amount =
			amount > this.items[from_slot].amount || amount <= 0
				? this.items[from_slot].amount
				: amount;
		if (invInstance.items[to_slot]) {
			if (invInstance.items[to_slot].item === this.items[from_slot].item) {
				const response = await Client("TAKE_PICKUP", {
                    item: this.items[from_slot].item,
                    id: this.items[from_slot].id,
                    amount: amount,
                    slot: to_slot,
                });
				if (typeof response !== "boolean" && response?.error) {
					Notify(response.error, "error");
					invInstance.renderSlots("left");
					this.renderSlots("right");
					return;
				}
				invInstance.items[to_slot].amount += amount;
				this.items[from_slot].amount -= amount;
				if (this.items[from_slot].amount <= 0) {
					delete this.items[from_slot];
				}
				invInstance.renderSlots("left");
				this.renderSlots("right");

				return true;
			}
		} else {
			const response = await Client("TAKE_PICKUP", {
				item: this.items[from_slot].item,
				id: this.items[from_slot].id,
				amount: amount,
				slot: to_slot,
			});
			if (typeof response !== "boolean" && response?.error) {
				Notify(response.error, "error");
				invInstance.renderSlots("left");
				this.renderSlots("right");
				return;
			}
			if (amount >= this.items[from_slot].amount) {
				invInstance.items[to_slot] = JSON.parse(
					JSON.stringify(this.items[from_slot]),
				);
				delete this.items[from_slot];
				invInstance.renderSlots("left");
				this.renderSlots("right");
				return true;
			}
			invInstance.items[to_slot] = JSON.parse(
				JSON.stringify(this.items[from_slot]),
			);
			invInstance.items[to_slot].amount = amount;
			this.items[from_slot].amount -= amount;
			invInstance.renderSlots("left");
			this.renderSlots("right");
			return true;
		}
	}

	async putItem(from_slot, amount, to_slot) {
		if (typeof from_slot === "number") from_slot = from_slot.toString();
		if (typeof to_slot === "number") to_slot = to_slot.toString();
		const invInstance = window.classInstances.left;
		amount =
			amount > invInstance.items[from_slot].amount || amount <= 0
				? invInstance.items[from_slot].amount
				: amount;

		if (invInstance.items[from_slot] && this.items[to_slot]) {
			if (invInstance.items[from_slot].item === this.items[to_slot].item) {
				const response = await Client("DROP_ITEM", {
					slot: from_slot,
					amount: amount,
				});
				if (typeof response !== "boolean" && response?.error) {
					Notify(response.error, "error");
					invInstance.renderSlots("left");
					this.renderSlots("right");
					return;
				}
				invInstance.items[from_slot].amount -= amount;
				if (invInstance.items[from_slot].amount <= 0) {
					delete invInstance.items[from_slot];
				}
				this.items[to_slot].amount += amount;
				this.renderSlots("right");
				invInstance.renderSlots("left");
				return true;
			}
			invInstance.renderSlots("left");
			this.renderSlots("right");
			return false;
		}

		if (invInstance.items[from_slot] && !this.items[to_slot]) {
			const response = await Client("DROP_ITEM", {
				slot: from_slot,
				amount: amount,
			});
			if (typeof response !== "boolean" && response?.error) {
				Notify(response.error, "error");
				invInstance.renderSlots("left");
				this.renderSlots("right");
				return;
			}
			if (amount >= invInstance.items[from_slot].amount) {
				this.items[to_slot] = JSON.parse(
					JSON.stringify(invInstance.items[from_slot]),
				);
				delete invInstance.items[from_slot];
				invInstance.renderSlots("left");
				this.renderSlots("right");
				return true;
			}
			invInstance.items[from_slot].amount -= amount;
			this.items[to_slot] = JSON.parse(
				JSON.stringify(invInstance.items[from_slot]),
			);
			this.items[to_slot].amount = amount;
			invInstance.renderSlots("left");
			this.renderSlots("right");
			return true;
		}
		invInstance.renderSlots("left");
		this.renderSlots("right");
		return false;
	}
}
