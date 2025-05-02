<template>
    <div id="domranking" v-if="opened">
        <div @click="onClose" class="close-wrapper">
            <p>SAIR</p>
            <div class="close-circle">X</div>
        </div>
        <div id="container">
            <header>
                <div class="logo-wrapper">
                    <p>DOMINAÇÃO</p>
                    <span>RANKING</span>
                </div>
                <nav>
                    <button @click="changeRanking('Geral')" class="btn-all"
                        :class="{ 'active-btn': activeRanking === 'Geral' }">GLOBAL</button>
                    <div class="navbar-wrapper">
                        <button @click="changeRanking('Armas')" :class="{ 'active-btn': activeRanking === 'Armas' }"
                            class="nav-btn">ARMA</button>
                        <button @click="changeRanking('Municao')" :class="{ 'active-btn': activeRanking === 'Municao' }"
                            class="nav-btn">MUNIÇÃO</button>
                        <button @click="changeRanking('Drogas')" :class="{ 'active-btn': activeRanking === 'Drogas' }"
                            class="nav-btn">DROGA</button>
                        <button @click="changeRanking('Desmanche')" :class="{ 'active-btn': activeRanking === 'Desmanche' }"
                            class="nav-btn">DESMANCHE</button>
                        <button @click="changeRanking('Lavagem')" :class="{ 'active-btn': activeRanking === 'Lavagem' }"
                            class="nav-btn">LAVAGEM</button>
                        <button @click="changeRanking('DominasGeral')" :class="{ 'active-btn': activeRanking === 'DominasGeral' }"
                            class="nav-btn">DOMINAS GERAL</button>
                    </div>
                </nav>
            </header>
            <main>
                <div class="title-wrapper">
                    <p>RANKING</p>
                </div>
                <div class="box-wrapper">
                    <div class="box-item silver">
                        <div class="box-emblem emblem-silver">
                            <img src="domranking/template/images/emblem.svg" />
                        </div>
                        <div class="box-text">
                            <p>NOME</p>
                            <span>{{ topRanking[1]?.org?.toUpperCase() || '-' }}</span>
                            <p>DOMINAÇÕES GANHAS</p>
                            <span>{{ topRanking[1]?.wins || 0 }}</span>
                        </div>
                    </div>
                    <div class="box-item gold">
                        <div class="box-emblem emblem-gold">
                            <img src="domranking/template/images/emblem.svg" />
                        </div>
                        <div class="box-text">
                            <p>NOME</p>
                            <span>{{ topRanking[0]?.org.toUpperCase() || '-' }}</span>
                            <p>DOMINAÇÕES GANHAS</p>
                            <span>{{ topRanking[0]?.wins || 0 }}</span>
                        </div>
                    </div>
                    <div class="box-item bronze">
                        <div class="box-emblem emblem-bronze">
                            <img src="domranking/template/images/emblem.svg" />
                        </div>
                        <div class="box-text">
                            <p>NOME</p>
                            <span>{{ topRanking[2]?.org.toUpperCase() || '-' }}</span>
                            <p>DOMINAÇÕES GANHAS</p>
                            <span>{{ topRanking[2]?.wins || 0 }}</span>
                        </div>
                    </div>
                </div>
                <table class="table-wrapper">
                    <thead>
                        <tr>
                            <th>POSIÇÃO</th>
                            <th>NOME</th>
                            <th>DOMINAÇÕES GANHAS</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-if="listRanking" v-for="(ranking, index) in listRanking" :key="index">
                            <td>
                                <div class="position-box">{{ ranking.position }}</div>
                            </td>
                            <td>{{ ranking.org }}</td>
                            <td>{{ ranking.wins }}</td>
                        </tr>
                    </tbody>
                </table>
            </main>
        </div>
    </div>
</template>

<style scoped> #domranking {
    width: 100vw;
    height: 100vh;
    background-image: url('domranking/template/images/background.png');
    background-size: 100% 100%;
}

#container {
    position: absolute;
    transform: translate(-50%, 0);
    left: 50%;
    bottom: 1.354vw;
    display: flex;
    flex-direction: column;
    align-items: center;
}

.logo-wrapper {
    display: flex;
    flex-direction: column;
    align-items: center;
    font-family: 'Medula One', cursive;
}

.logo-wrapper p {
    font-weight: 400;
    font-size: 2.571vw;
    background: linear-gradient(180deg, #FFFFFF 0%, rgba(255, 255, 255, 0) 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    text-fill-color: transparent;
    text-shadow: 0px 0px 1.644vw rgba(255, 255, 255, 0.13);
    -webkit-text-stroke: 0.028vw #FFFFFF;
}

.logo-wrapper span {
    font-weight: 400;
    font-size: 6.177vw;
    background: linear-gradient(180deg, #FFFFFF 0%, rgba(255, 255, 255, 0) 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    text-fill-color: transparent;
    text-shadow: 0vw 0vw 3.95vw rgba(255, 255, 255, 0.13);
    -webkit-text-stroke: 0.068vw #FFFFFF;
    margin-top: -0.781vw;
}

nav {
    margin-top: 2.344vw;
    display: flex;
    flex-direction: column;
    align-items: center;
}

.btn-all {
    width: 9.896vw;
    height: 2.135vw;
    background: #202020;
    border-radius: 0.334vw;
    font-family: 'Inter', sans-serif;
    font-weight: 900;
    font-size: 1.001vw;
    letter-spacing: -0.005em;
    color: #373737;
    outline: none;
    border: none;
    cursor: pointer;
    transition: all ease .4s;
}

.btn-all:hover {
    background: rgba(211, 19, 47);
    color: #FFF;
}

.btn-all:active {
    background: #202020;
}

.navbar-wrapper {
    height: 1.667vw;
    display: flex;
    gap: 0.469vw;
    margin-top: 0.573vw;
}

.nav-btn {
    width: 7.76vw;
    height: 1.667vw;
    background: #202020;
    border-radius: 0.26vw;
    outline: none;
    border: none;
    font-weight: 900;
    color: #373737;
    font-size: 0.781vw;
    cursor: pointer;
    transition: all ease .4s;
}

.nav-btn:hover {
    background: rgba(211, 19, 47);
    color: #FFF;
}

.nav-btn:active {
    background: #202020;
}

.active-btn {
    background: rgba(211, 19, 47) !important;
    color: #FFF !important;
}

main {
    margin-top: 2.031vw;
    display: flex;
    flex-direction: column;
    align-items: center;
}

.title-wrapper {
    width: 51.042vw;
    font-weight: 600;
    font-size: 1.279vw;
    font-family: 'Montserrat', sans-serif;
    color: #FFFFFF;
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 0.885vw;
}


.title-wrapper::before {
    content: '';
    flex: 1;
    height: 0.052vw;
    background-color: rgba(255, 255, 255, .15);
}

.title-wrapper::after {
    content: '';
    flex: 1;
    height: 0.052vw;
    background-color: rgba(255, 255, 255, .15);
}

.box-wrapper {
    margin-top: 1.094vw;
    display: flex;
    gap: 0.781vw;
}

.box-item {
    width: 12.135vw;
    height: 5.313vw;
    border-radius: 0.625vw;
    position: relative;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    font-family: 'Montserrat';
}

.box-text {
    margin-top: 0.521vw;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}

.box-text p {
    font-weight: 300;
    font-size: 0.469vw;
    color: #8C8C8C;
}

.box-text span {
    font-weight: 600;
    font-size: 0.992vw;
    color: #FFFFFF;
}

.box-item:nth-child(1) {
    margin-top: 0.781vw;
}

.box-item:nth-child(3) {
    margin-top: 0.781vw;
}

.silver {
    background: radial-gradient(88.2% 201.47% at 0% 0%, rgba(255, 255, 255, 0.55) 0%, rgba(0, 0, 0, 0) 100%)
        /* warning: gradient uses a rotation that is not supported by CSS and may not behave as expected */
        , #222222;
    box-shadow: 0vw 0vw 2.396vw rgba(255, 255, 255, 0.15);
}

.gold {
    background: radial-gradient(88.2% 201.47% at 0% 0%, rgba(255, 214, 0, 0.55) 0%, rgba(0, 0, 0, 0) 100%)
        /* warning: gradient uses a rotation that is not supported by CSS and may not behave as expected */
        , #222222;
    box-shadow: 0vw 0vw 2.396vw rgba(255, 214, 0, 0.15);
}

.bronze {
    background: radial-gradient(88.2% 201.47% at 0% 0%, rgba(255, 173, 138, 0.55) 0%, rgba(0, 0, 0, 0) 100%)
        /* warning: gradient uses a rotation that is not supported by CSS and may not behave as expected */
        , #222222;
    box-shadow: 0vw 0vw 2.396vw rgba(205, 136, 107, 0.15);
}

.box-emblem {
    width: 1.875vw;
    height: 1.25vw;
    border-radius: 0.156vw;
    transform: translate(-50%, -50%);
    position: absolute;
    left: 50%;
    top: 0;
    display: flex;
    justify-content: center;
    align-items: center;
}

.box-emblem img {
    height: 0.99vw;
}

.emblem-silver {
    background: #BEBEBE;
    box-shadow: 0vw 0vw 0.938vw rgba(255, 214, 0, 0.14);
}

.emblem-gold {
    background: #FFD600;
    box-shadow: 0vw 0vw 0.938vw rgba(255, 214, 0, 0.14);
}

.emblem-bronze {
    background: #CD886B;
    box-shadow: 0vw 0vw 0.938vw rgba(255, 214, 0, 0.14);
}

.table-wrapper {
    width: 33.073vw;
    margin-top: 1.979vw;
    border-collapse: collapse;
    font-family: 'Montserrat';
    display: flex;
    flex-direction: column;
    gap: 0.365vw;
    position: relative;
}

.table-wrapper thead td:not(:first-child),
.table-wrapper thead th:not(:first-child) {
    border-right: 0.052vw solid rgba(255, 255, 255, 0.11);
    border-bottom: 0.052vw solid rgba(255, 255, 255, 0.11);
}

.table-wrapper thead td:first-child,
.table-wrapper thead th:first-child,
.table-wrapper thead td:nth-child(2),
.table-wrapper thead th:nth-child(2) {
    border-right: 0.052vw solid rgba(255, 255, 255, 0.11);
    border-bottom: 0.052vw solid rgba(255, 255, 255, 0.11);
}

.table-wrapper thead tr {
    width: 100%;
    height: 1.171875vw;
    display: grid;
    grid-template-columns: .23fr .6fr 1fr;
    font-weight: 300;
    font-size: 0.685vw;
    color: #8C8C8C;
}

.table-wrapper tbody {
    width: 33.5vw;
    height: 20.738vw;
    display: grid;
    grid-gap: 0.307vw;
    align-content: flex-start;
    overflow: hidden auto;
}

.table-wrapper tbody tr {
    width: 33.073vw;
    height: 2.031vw;
    display: grid;
    place-items: center;
    grid-template-columns: .23fr .6fr 1fr;
    background: #222222;
    border-radius: 0.9375vw;
    font-weight: 600;
    font-size: 0.685vw;
    color: #FFF;
}

.table-wrapper ::-webkit-scrollbar {
    width: 0.104vw;
}

.table-wrapper ::-webkit-scrollbar-track {
    background: rgba(255, 255, 255, 0.03);
}

.table-wrapper ::-webkit-scrollbar-thumb {
    background: rgba(211, 19, 47);
}

.position-box {
    width: 4vw;
    height: 2.031vw;
    background: rgba(211, 19, 47);
    border-radius: 0.625vw;
    margin-left: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    font-weight: 600;
    font-size: 1.556vw;
    color: #FFF;
}

.close-wrapper {
    position: absolute;
    right: 0;
    top: 0;
    margin: 2.604vw;
    display: flex;
    align-items: center;
    gap: 0.781vw;
    font-family: 'Montserrat';
    font-size: 0.729vw;
    font-weight: 700;
    color: #FFF;
    cursor: pointer;
    transition: all ease .4s;
}

.close-wrapper:hover {
    opacity: .5;
}

.close-wrapper:active {
    opacity: 1;
}

.close-circle {
    width: 1.563vw;
    height: 1.563vw;
    background: rgba(211, 19, 47);
    border-radius: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
}

@media screen and (min-width: 2560px) and (max-width: 2560px) {
    #container {
        zoom: .8;
    }
}
</style>

<script>
export default {
    data() {
        return {
            opened: false,
            topRanking: [],
            listRanking: [],
            activeRanking: 'Geral',
        };
    },
    methods: {
        onOpen: async function () {
            const res = await this.request('getInitial');
            if (!res) return;

            const [topRanking, listRanking] = res;
            Object.assign(this, { opened: true, topRanking, listRanking });
        },
        changeTopRanking: async function () {
            const res = await this.request('getTopDominas');
            if (!res) return;

            const [topRanking, listRanking] = res;
            Object.assign(this, { opened: true, topRanking, listRanking });
        },
        changeRanking: async function (ranking = 'Geral') {
            if (ranking === this.activeRanking) return;

            if (ranking === 'Geral') {
                return this.onOpen();
            }

            if (ranking === 'DominasGeral') {
                this.changeTopRanking();
            }

            const res = await this.request('getRanking', { type: ranking });
            if (!res) return;

            this.activeRanking = ranking;
            this.listRanking = res;
        },
        onClose: function () {
            this.opened = false;
            this.post('closeRanking');
            Object.assign(this, { topRanking: [], listRanking: [], activeRanking: 'Geral' });
        },
    },
};
</script>
