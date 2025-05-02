<template>
    <div id="domfeed">
        <transition name="emblem-transition">
            <div v-if="showEmblem" class="emblem-wrapper">
                <img :src="emblemSrc" />
            </div>
        </transition>
        <div class="notify-wrapper">
            <transition-group name="notification-list" tag="div">
                <div v-for="(notification, index) in notifications" :key="index" class="notify-item">
                    <p>{{ notification.killer }}</p>
                    <img :src="`domfeed/template/images/${notification.weapon}.svg`" />
                    <p>{{ notification.victim }}</p>
                </div>
            </transition-group>
        </div>
        <transition name="star-transition">
            <img v-if="showStar" :src="starSrc" class="star-wrapper" :key="currentStar" />
        </transition>
    </div>
</template>
  
<style scoped>
#domfeed {
    width: 100vw;
    height: 100vh;
    font-family: 'Montserrat', sans-serif;
}

.emblem-wrapper {
    position: absolute;
    top: 10.417vw;
    right: 1.719vw;
}

.emblem-wrapper img {
    height: 7.813vw;
}

.notify-wrapper {
    position: absolute;
    top: 10.417vw;
    right: 0.365vw;
    display: flex;
    flex-direction: column;
    gap: 0.208vw;
}

.notify-item {
    width: 100%;
    height: 2.031vw;
    background: linear-gradient(270deg, rgba(211, 19, 47, 0.6) 0%, rgba(0, 80, 205, 0) 134.25%);
    padding: 0 2.031vw;
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 0.833vw;
    font-weight: 700;
    font-size: 0.417vw;
    color: #FFF;
}

.notify-item img {
    height: 1.146vw;
}

.star-wrapper {
    height: 6.51vw;
    transform: translate(-50%);
    position: absolute;
    left: 50%;
    bottom: 5.885vw;
}

.emblem-transition-enter-active,
.emblem-transition-leave-active {
    transition: opacity 0.5s ease-in-out;
}

.emblem-transition-enter,
.emblem-transition-leave-to {
    opacity: 0;
}

.notification-list-enter-active,
.notification-list-leave-active {
    transition: transform 0.5s ease-in-out;
}

.notification-list-enter,
.notification-list-leave-to {
    transform: translateY(-100%);
}

.star-transition-enter-active,
.star-transition-leave-active {
    transition: opacity 0.5s ease-in-out;
}

.star-transition-enter,
.star-transition-leave-to {
    opacity: 0;
}
</style>
  
<script>
export default {
    data() {
        return {
            showEmblem: false,
            emblemType: null,
            notifications: [],
            currentStar: null,
            showStar: false,
            starTimeoutId: null
        }
    },
    methods: {
        onUpdate({ action, payload }) {
            const actions = {
                emblem: () => this.handleEmblemAction(payload),
                notifyKill: () => {
                    const { killer, weapon, victim } = payload || {};
                    if (killer && weapon && victim) {
                        this.addNotification(killer, weapon, victim);
                    }
                },
                killStreak: () => this.showStarImage(payload),
            };

            const actionHandler = actions[action];
            if (actionHandler) {
                actionHandler();
            }
        },
        handleEmblemAction(payload) {
            this.emblemType = payload
            this.showEmblem = true
            setTimeout(() => {
                this.showEmblem = false;
                this.emblemType = null;
            }, 5000)
        },
        addNotification(killer, weapon, victim) {
            const timestamp = Date.now()
            this.notifications.push({
                killer,
                weapon,
                victim,
                timestamp
            })
            setInterval(() => {
                this.notifications.shift()
            }, 8000)
        },
        showStarImage(starNumber) {
            if (starNumber > 5) {
                starNumber = 5;
            }

            this.currentStar = starNumber;
            this.showStar = true;

            if (this.starTimeoutId) {
                clearTimeout(this.starTimeoutId);
            }

            this.starTimeoutId = setTimeout(() => {
                this.showStar = false;
                this.currentStar = null;
            }, 5000);
        },
    },
    computed: {
        emblemSrc() {
            return this.showEmblem && this.emblemType ? `domfeed/template/images/${this.emblemType.type}-${this.emblemType.mode}.svg` : ''
        },
        starSrc() {
            return this.currentStar ? `domfeed/template/images/star-${this.currentStar}.png` : '';
        },
    }
}
</script>
  