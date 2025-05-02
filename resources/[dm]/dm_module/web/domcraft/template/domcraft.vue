<template>
    <transition name="fade">
        <div id="domcraft" v-if="opened">
            <div class="notify-wrapper">
                <div class="notify">
                    <div class="notify-title">Itens do armazem:</div>
                    <div class="notify-infos">
                        <p v-for="item in storage" :key="item.item">
                            ITEM: <b>{{ item.name }}</b>
                            Quantidade: <b>{{ item.amount }}x</b>
                        </p>
                    </div>
                </div>
            </div>
            <div class="left-wrapper">
                <div class="title-wrapper">
                    <p>SISTEMA</p>
                    <span>CRAFT</span>
                </div>
                <div class="items-wrapper">
                    <div v-for="(item, key) in items" :key="`${item.item}_${key}`" @click="changeSelected(item, key)"
                        class="item" :class="{ 'active-item': item.item === itemSelected.item }">
                        <img class="item-weapon" :src="imageSrc(item.item)" />
                        <div class="item-infos">
                            <div class="item-title-wrapper">
                                <p>Requer</p>
                            </div>
                            <div class="item-box-wrapper">
                                <div v-for="(requirement, index) in item.requires.slice(0, 4)"
                                    :key="`${requirement.item}_${index}`" class="item-box">
                                    <img :src="imageSrc(requirement.item)" />
                                    <span>{{ requirement.amount }}x</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div v-if="itemSelected && itemSelected.requires" class="main-wrapper">
                <div class="product-title">
                    <span>{{ itemSelected.name }}</span>
                </div>
                <div class="product-photo">
                    <img :src="imageSrc(itemSelected.item)" />
                </div>
                <div class="product-items">
                    <div v-for="(requirement, index) in itemSelected.requires.slice(0, 6)"
                        :key="`${requirement.item}_${index}`" class="product-item">
                        <div class="product-item-photo">
                            <img :src="imageSrc(requirement.item)" />
                        </div>
                        <div class="product-item-text">
                            <span>{{ requirement.name }}</span>
                            <p>{{ requirement.amount * quantity }}x</p>
                        </div>
                    </div>
                </div>
                <div class="product-options">
                    <div class="quantity-wrapper">
                        <button @click="decrementQuantity">
                            <img src="domcraft/template/images/less.svg" />
                        </button>
                        <input type="number" v-model="quantity" readonly :min="minQuantity" :max="maxQuantity" />
                        <button @click="incrementQuantity" :disabled="quantity >= maxQuantity">
                            <img src="domcraft/template/images/plus.svg" />
                        </button>
                    </div>
                    <button @click="changeProduce" class="btn-produce">PRODUZIR</button>
                    <div class="time-wrapper">
                        <img src="domcraft/template/images/time.svg" />
                        <div class="time-text">
                            <p>Tempo</p>
                            <span>{{ formattedTime }}</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </transition>
</template>

<style scoped>
#domcraft {
    width: 100vw;
    height: 100vh;
    background-image: url('domcraft/template/images/background.png');
    background-size: 100% 100%;
    font-family: 'Montserrat', sans-serif;
}

.left-wrapper {
    width: 20.885vw;
    height: 100%;
    position: absolute;
    top: 0;
    left: 2.969vw;
    display: flex;
    flex-direction: column;
}

.title-wrapper {
    display: flex;
    flex-direction: column;
    margin-top: 3.229vw;
}

.title-wrapper p {
    font-style: normal;
    font-weight: 500;
    font-size: 2.377vw;
    color: #FFFFFF;
    line-height: 2.377vw;
}

.title-wrapper span {
    font-style: normal;
    font-weight: 900;
    font-size: 5.051vw;
    line-height: 5.051vw;
    color: rgba(211, 19, 47);
}

.items-wrapper {
    flex: 1;
    margin-top: 2.76vw;
    display: flex;
    flex-wrap: wrap;
    gap: 0.417vw;
    overflow: hidden scroll;
    padding-bottom: .5vw;
}

.item {
    position: relative;
    width: 19.844vw;
    height: 6.51vw;
    border-radius: 0.521vw;
    background: #101010;
    cursor: pointer;
    overflow: hidden;
    display: flex;
    align-items: center;
}

.item::before {
    content: "";
    position: absolute;
    top: -10%;
    left: -10%;
    width: 120%;
    height: 120%;
    background: radial-gradient(73.36% 223.6% at -3.81% 47.6%, rgba(211, 19, 47, 0.2) 0%, rgba(0, 100, 255, 0) 100%);
    opacity: 0;
    border-radius: inherit;
    transition: opacity 0.4s ease;
}

.item:hover::before {
    opacity: 1;
}

.item:hover {
    background: #101010;
    transition: all ease .4s;
}

.item:active {
    opacity: .5;
}

.item::after {
    content: '';
    width: 0.313vw;
    height: 2.448vw;
    background: rgba(211, 19, 47);
    border-radius: 0vw 0.26vw 0.26vw 0vw;
    position: absolute;
    left: 0;
    opacity: 0;
    transition: opacity 0.4s ease;
}

.item:hover::after {
    opacity: 1;
}

.item-weapon {
    z-index: 1;
    height: 4vw;
    margin-left: 0.625vw;
    transition: all ease .4s;
}

.item:hover .item-weapon {
    transform: scale(1.1);
    transition: transform ease .4s;
}

.item.active-item::before,
.item:hover::before {
    opacity: 1;
}

.item.active-item {
    background: #101010;
    transition: all ease .4s;
}

.item.active-item::after,
.item:hover::after {
    opacity: 1;
}

.item.active-item .item-weapon,
.item:hover .item-weapon {
    transform: scale(1.1);
    transition: transform ease .4s;
}

.item-infos {
    z-index: 1;
    width: 10.677vw;
    right: 1.146vw;
    position: absolute;
    display: flex;
    flex-direction: column;
    gap: 0.313vw;
}

.item-title-wrapper {
    display: flex;
    align-items: center;
    gap: 0.521vw;
    font-style: normal;
    font-weight: 500;
    font-size: 0.693vw;
    color: #FFF;
}

.item-title-wrapper::after {
    content: '';
    width: 100%;
    height: 0.052vw;
    background-color: rgba(255, 255, 255, 0.14);
}

.item-box-wrapper {
    width: 100%;
    height: 2.188vw;
    display: flex;
    justify-content: space-between;
}

.item-box {
    width: 2.083vw;
    height: 2.083vw;
    background: linear-gradient(270deg, #2C2C2C 0%, rgba(63, 63, 63, 0) 139.19%);
    border-radius: 0.125vw;
    display: flex;
    justify-content: center;
    align-items: center;
    position: relative;
}

.item-box img {
    height: 1.5vw;
}

.item-box span {
    font-size: 0.521vw;
    color: #FFF;
    position: absolute;
    right: 0.156vw;
    bottom: 0.052vw;
}

.main-wrapper {
    position: absolute;
    bottom: 0;
    left: 50%;
    transform: translate(-50%);
    display: flex;
    flex-direction: column;
    align-items: center;
}

.product-title {
    display: flex;
    flex-direction: column;
    align-items: center;
}

.product-title span {
    font-weight: 500;
    font-size: 1.715vw;
    color: #FFFFFF;
}

.product-title p {
    font-weight: 400;
    font-size: 1.17vw;
    color: #565656;
}

.product-photo {
    width: 21.875vw;
    height: 19.792vw;
    background: url('domcraft/template/images/photo-frame.png');
    background-size: 100% 100%;
    margin-top: 1.198vw;
    display: flex;
    justify-content: center;
    align-items: center;
}

.product-photo img {
    height: 23vw;
}

.product-items {
    height: 9.063vw;
    margin-top: 1.875vw;
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 0.521vw;
}

.product-item {
    width: 12.344vw;
    display: flex;
    gap: 0.521vw;
    align-items: center;
}

.product-item-photo {
    width: 3.646vw;
    height: 3.646vw;
    background: linear-gradient(270deg, #2C2C2C 0%, rgba(63, 63, 63, 0) 139.19%);
    border-radius: 0.221vw;
    display: flex;
    justify-content: center;
    align-items: center;
}

.product-item-photo img {
    height: 3vw;
}

.product-item-text {
    display: flex;
    flex-direction: column;
    gap: 0.313vw;
}

.product-item-text span {
    font-weight: 800;
    font-size: 0.859vw;
    color: rgba(211, 19, 47);
}

.product-item-text p {
    font-weight: 300;
    font-size: 0.859vw;
    color: #FFFFFF;
}

.product-options {
    height: 3.49vw;
    margin-top: 2.969vw;
    margin-bottom: 2.813vw;
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 2.188vw;
}

.quantity-wrapper {
    display: flex;
    align-items: center;
    gap: 0.729vw;
}

.quantity-wrapper button {
    width: 2.083vw;
    height: 2.083vw;
    background: rgba(211, 19, 47);
    border-radius: 0.26vw;
    color: #FFF;
    font-size: 1.042vw;
    font-weight: 700;
    border: none;
    outline: none;
    cursor: pointer;
    transition: all ease .4s;
    display: flex;
    justify-content: center;
    align-items: center;
}

.quantity-wrapper button:hover {
    background: rgb(113, 4, 20);
}

.quantity-wrapper button:active {
    background: rgba(211, 19, 47);
}

.quantity-wrapper button img {
    width: 0.833vw;
}

.quantity-wrapper input {
    width: 3vw;
    height: 2.76vw;
    background: #101010;
    border-radius: 0.26vw;
    outline: none;
    border: none;
    font-weight: 600;
    font-size: 1.506vw;
    color: #FFF;
    text-align: center;
}

.btn-produce {
    width: 12.292vw;
    height: 3.49vw;
    background: #101010;
    border-radius: 0.26vw;
    font-weight: 600;
    font-size: 1.506vw;
    outline: none;
    border: none;
    color: #535353;
    cursor: pointer;
    transition: all ease .4s;
}

.btn-produce:hover {
    background: rgba(211, 19, 47);
    color: #FFF;
}

.btn-produce:active {
    opacity: .5;
}

.time-wrapper {
    display: flex;
    align-items: center;
    gap: 0.365vw;
}

.time-wrapper img {
    height: 1.823vw;
}

.time-text {
    width: 5vw;
    display: flex;
    flex-direction: column;
    gap: 0.365vw;
}

.time-text p {
    font-weight: 400;
    font-size: 0.765vw;
    color: #FFFFFF;
}

.time-text span {
    font-weight: 600;
    font-size: 0.765vw;
    color: rgba(211, 19, 47);
}

.notify-wrapper {
    position: absolute;
    right: 0;
    top: 0;
    margin: 3.125vw;
    display: flex;
    flex-direction: column;
    gap: 0.521vw;
    ;
}

.notify {
    min-width: 19.844vw;
    padding: 1.042vw 1.094vw;
    background: radial-gradient(73.36% 223.6% at -3.81% 47.6%, rgba(211, 19, 47, 0.2) 0%, rgba(0, 100, 255, 0) 100%), #101010;
    border-radius: 0.521vw;
    display: flex;
    flex-direction: column;
    justify-content: center;
}

.notify::after {
    content: '';
    width: 0.313vw;
    height: 2.031vw;
    background: rgba(211, 19, 47);
    border-radius: 0.26vw 0vw 0vw 0.26vw;
    right: 0;
    position: absolute;
}

.notify-title {
    font-weight: 700;
    font-size: 0.998vw;
    color: #FFF;
}

.notify-infos {
    display: flex;
    flex-direction: column;
    gap: 0.052vw;
    margin-top: 0.365vw;
    font-weight: 500;
    font-size: 0.833vw;
    color: #FFF;
}

::-webkit-scrollbar {
    width: 0.104vw;
}

::-webkit-scrollbar-track {
    background: rgba(255, 255, 255, 0.03);
}

::-webkit-scrollbar-thumb {
    background: rgba(211, 19, 47);
}

input[type=number]::-webkit-inner-spin-button {
    -webkit-appearance: none;

}

input[type=number] {
    -moz-appearance: textfield;
    appearance: textfield;

}

.fade-enter {
    opacity: 0;
}

.fade-leave-to {
    opacity: 0;
}

.fade-enter-active,
.fade-leave-active {
    transition: opacity 0.5s ease-out;
}

.fade-enter-to {
    opacity: 1;
    transition-delay: 0.2s;
}

#domcraft {
    width: 100vw;
    height: 100vh;
    background-image: url('domcraft/template/images/background.png');
    background-size: 100% 100%;
    font-family: 'Montserrat', sans-serif;
}

.left-wrapper {
    width: 20.885vw;
    height: 100%;
    position: absolute;
    top: 0;
    left: 2.969vw;
    display: flex;
    flex-direction: column;
}

.title-wrapper {
    display: flex;
    flex-direction: column;
    margin-top: 3.229vw;
}

.title-wrapper p {
    font-style: normal;
    font-weight: 500;
    font-size: 2.377vw;
    color: #FFFFFF;
    line-height: 2.377vw;
}

.title-wrapper span {
    font-style: normal;
    font-weight: 900;
    font-size: 5.051vw;
    line-height: 5.051vw;
    color: rgba(211, 19, 47, 0.85);
}

.items-wrapper {
    flex: 1;
    margin-top: 2.76vw;
    display: flex;
    flex-wrap: wrap;
    gap: 0.417vw;
    overflow: hidden scroll;
    padding-bottom: .5vw;
}

.item {
    position: relative;
    width: 19.844vw;
    height: 6.51vw;
    border-radius: 0.521vw;
    background: #101010;
    cursor: pointer;
    overflow: hidden;
    display: flex;
    align-items: center;
}

.item::before {
    content: "";
    position: absolute;
    top: -10%;
    left: -10%;
    width: 120%;
    height: 120%;
    background: radial-gradient(73.36% 223.6% at -3.81% 47.6%, rgba(211, 19, 47, 0.2) 0%, rgba(0, 100, 255, 0) 100%);
    opacity: 0;
    border-radius: inherit;
    transition: opacity 0.4s ease;
}

.item:hover::before {
    opacity: 1;
}

.item:hover {
    background: #101010;
    transition: all ease .4s;
}

.item:active {
    opacity: .5;
}

.item::after {
    content: '';
    width: 0.313vw;
    height: 2.448vw;
    background: rgba(211, 19, 47, 0.85);
    border-radius: 0vw 0.26vw 0.26vw 0vw;
    position: absolute;
    left: 0;
    opacity: 0;
    transition: opacity 0.4s ease;
}

.item:hover::after {
    opacity: 1;
}

.item-weapon {
    z-index: 1;
    height: 4vw;
    margin-left: 0.625vw;
    transition: all ease .4s;
}

.item:hover .item-weapon {
    transform: scale(1.1);
    transition: transform ease .4s;
}

.item.active-item::before,
.item:hover::before {
    opacity: 1;
}

.item.active-item {
    background: #101010;
    transition: all ease .4s;
}

.item.active-item::after,
.item:hover::after {
    opacity: 1;
}

.item.active-item .item-weapon,
.item:hover .item-weapon {
    transform: scale(1.1);
    transition: transform ease .4s;
}

.item-infos {
    z-index: 1;
    width: 10.677vw;
    right: 1.146vw;
    position: absolute;
    display: flex;
    flex-direction: column;
    gap: 0.313vw;
}

.item-title-wrapper {
    display: flex;
    align-items: center;
    gap: 0.521vw;
    font-style: normal;
    font-weight: 500;
    font-size: 0.693vw;
    color: #FFF;
}

.item-title-wrapper::after {
    content: '';
    width: 100%;
    height: 0.052vw;
    background-color: rgba(255, 255, 255, 0.14);
}

.item-box-wrapper {
    width: 100%;
    height: 2.188vw;
    display: flex;
    justify-content: space-between;
}

.item-box {
    width: 2.083vw;
    height: 2.083vw;
    background: linear-gradient(270deg, #2C2C2C 0%, rgba(63, 63, 63, 0) 139.19%);
    border-radius: 0.125vw;
    display: flex;
    justify-content: center;
    align-items: center;
    position: relative;
}

.item-box img {
    height: 1.5vw;
}

.item-box span {
    font-size: 0.521vw;
    color: #FFF;
    position: absolute;
    right: 0.156vw;
    bottom: 0.052vw;
}

.main-wrapper {
    position: absolute;
    bottom: 0;
    left: 50%;
    transform: translate(-50%);
    display: flex;
    flex-direction: column;
    align-items: center;
}

.product-title {
    display: flex;
    flex-direction: column;
    align-items: center;
}

.product-title span {
    font-weight: 500;
    font-size: 1.715vw;
    color: #FFFFFF;
}

.product-title p {
    font-weight: 400;
    font-size: 1.17vw;
    color: #565656;
}

.product-photo {
    width: 21.875vw;
    height: 19.792vw;
    background: url('domcraft/template/images/photo-frame.png');
    background-size: 100% 100%;
    margin-top: 1.198vw;
    display: flex;
    justify-content: center;
    align-items: center;
}

.product-photo img {
    height: 23vw;
}

.product-items {
    height: 9.063vw;
    margin-top: 1.875vw;
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 0.521vw;
}

.product-item {
    width: 12.344vw;
    display: flex;
    gap: 0.521vw;
    align-items: center;
}

.product-item-photo {
    width: 3.646vw;
    height: 3.646vw;
    background: linear-gradient(270deg, #2C2C2C 0%, rgba(63, 63, 63, 0) 139.19%);
    border-radius: 0.221vw;
    display: flex;
    justify-content: center;
    align-items: center;
}

.product-item-photo img {
    height: 3vw;
}

.product-item-text {
    display: flex;
    flex-direction: column;
    gap: 0.313vw;
}

.product-item-text span {
    font-weight: 800;
    font-size: 0.859vw;
    color: rgba(211, 19, 47, 0.85);
}

.product-item-text p {
    font-weight: 300;
    font-size: 0.859vw;
    color: #FFFFFF;
}

.product-options {
    height: 3.49vw;
    margin-top: 2.969vw;
    margin-bottom: 2.813vw;
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 2.188vw;
}

.quantity-wrapper {
    display: flex;
    align-items: center;
    gap: 0.729vw;
}

.quantity-wrapper button {
    width: 2.083vw;
    height: 2.083vw;
    background: rgba(211, 19, 47, 0.85);
    border-radius: 0.26vw;
    color: #FFF;
    font-size: 1.042vw;
    font-weight: 700;
    border: none;
    outline: none;
    cursor: pointer;
    transition: all ease .4s;
    display: flex;
    justify-content: center;
    align-items: center;
}

.quantity-wrapper button:hover {
    background: rgba(211, 19, 47, 0.5);
}

.quantity-wrapper button:active {
    background: rgba(211, 19, 47, 0.85);
}

.quantity-wrapper button img {
    width: 0.833vw;
}

.quantity-wrapper input {
    width: 3vw;
    height: 2.76vw;
    background: #101010;
    border-radius: 0.26vw;
    outline: none;
    border: none;
    font-weight: 600;
    font-size: 1.506vw;
    color: #FFF;
    text-align: center;
}

.btn-produce {
    width: 12.292vw;
    height: 3.49vw;
    background: #101010;
    border-radius: 0.26vw;
    font-weight: 600;
    font-size: 1.506vw;
    outline: none;
    border: none;
    color: #535353;
    cursor: pointer;
    transition: all ease .4s;
}

.btn-produce:hover {
    background: rgba(211, 19, 47, 0.85);
    color: #FFF;
}

.btn-produce:active {
    opacity: .5;
}

.time-wrapper {
    display: flex;
    align-items: center;
    gap: 0.365vw;
}

.time-wrapper img {
    height: 1.823vw;
}

.time-text {
    width: 5vw;
    display: flex;
    flex-direction: column;
    gap: 0.365vw;
}

.time-text p {
    font-weight: 400;
    font-size: 0.765vw;
    color: #FFFFFF;
}

.time-text span {
    font-weight: 600;
    font-size: 0.765vw;
    color: rgba(211, 19, 47, 0.85);
}

.notify-wrapper {
    position: absolute;
    right: 0;
    top: 0;
    margin: 3.125vw;
    display: flex;
    flex-direction: column;
    gap: 0.521vw;
}

.notify {
    min-width: 19.844vw;
    padding: 1.042vw 1.094vw;
    background: radial-gradient(223.60% 73.36% at -3.81% 47.60%, rgba(211, 19, 47, 0.2) 0%, rgba(151, 71, 255, 0) 100%), #101010;
    border-radius: 0.521vw;
    display: flex;
    flex-direction: column;
    justify-content: center;
}

.notify::after {
    content: '';
    width: 0.313vw;
    height: 2.031vw;
    background: rgba(211, 19, 47, 0.85);
    border-radius: 0.26vw 0vw 0vw 0.26vw;
    right: 0;
    position: absolute;
}

.notify-title {
    font-weight: 700;
    font-size: 0.998vw;
    color: #FFF;
}

.notify-infos {
    display: flex;
    flex-direction: column;
    gap: 0.052vw;
    margin-top: 0.365vw;
    font-weight: 500;
    font-size: 0.833vw;
    color: #FFF;
}

::-webkit-scrollbar {
    width: 0.104vw;
}

::-webkit-scrollbar-track {
    background: rgba(255, 255, 255, 0.03);
}

::-webkit-scrollbar-thumb {
    background: rgba(211, 19, 47);
}

input[type=number]::-webkit-inner-spin-button {
    -webkit-appearance: none;
}

input[type=number] {
    -moz-appearance: textfield;
    appearance: textfield;
}

.fade-enter {
    opacity: 0;
}

.fade-leave-to {
    opacity: 0;
}

.fade-enter-active,
.fade-leave-active {
    transition: opacity 0.5s ease-out;
}

.fade-enter-to {
    opacity: 1;
    transition-delay: 0.2s;
}
</style>

<script>
export default {
    data() {
        return {
            opened: false,
            quantity: 1,
            totalTime: 0,
            items: [],
            storage: [],
            itemSelected: {},
            disableInput: false,
            minQuantity: 1,
            maxQuantity: 30,
            key: null
        }
    },
    methods: {
        formatTime(time) {
            let hours = Math.floor(time / 3600);
            let minutes = Math.floor((time % 3600) / 60);
            let seconds = time % 60;
            let formattedHours = hours.toString().padStart(2, '0');
            let formattedMinutes = minutes.toString().padStart(2, '0');
            let formattedSeconds = seconds.toString().padStart(2, '0');
            let formattedTime = '';

            if (hours > 0) {
                formattedTime += `${formattedHours}h`;
            }

            if (minutes > 0 || hours > 0) {
                formattedTime += `${formattedMinutes}m`;
            }

            formattedTime += `${formattedSeconds}s`;

            return formattedTime;
        },
        async onOpen() {
            const res = await this.request('requestCraft');
            if (res) {
                this.items = res.items;
                this.storage = res.storage;
                this.opened = true;
            }
        },
        changeSelected(item, key) {
            if (item) {
                this.key = key;
                this.quantity = 1;
                this.itemSelected = item;
            }
        },
        incrementQuantity() {
            if (this.quantity < this.maxQuantity) {
                this.quantity = this.quantity + 1;
            }
        },
        decrementQuantity() {
            if (this.quantity > this.minQuantity) {
                this.quantity = this.quantity - 1;
            }
        },
        changeProduce() {
            this.request('startProduction', {
                index: this.key + 1,
                amount: this.quantity
            });
            this.onClose();
        },
        onClose() {
            this.post('closeCraft');
            this.opened = false;
            this.quantity = 1;
            this.totalTime = 0;
            this.items = [];
            this.itemSelected = {};
            this.key = null;
        },
        updateTotalTime() {
            this.totalTime = this.itemSelected.time * this.quantity;
        }
    },
    watch: {
        itemSelected: function (item) {
            this.updateTotalTime();
        },
        quantity: function (val) {
            this.updateTotalTime();
        }
    },
    computed: {
        imageSrc() {
            return (item) => {
                return `http://177.54.148.31:4020/lotus/inventario_021/${item}.png`
            }
        },
        formattedTime() {
            return this.formatTime(this.totalTime);
        }
    }
}
</script>