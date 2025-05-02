window.addEventListener('keydown', ({ key }) => {
  if (key === 'Escape') {
    $.post( "http://ranking_chamados/close");
  }
})

window.addEventListener('message', ({ data }) => {
  if (data.showmenu) {
    const userIndex = data.ranking.findIndex(p => p.isMy)
    const userProps = data.ranking[userIndex]
    const userPosition = userIndex + 1

    console.log(JSON.stringify(data.ranking))
    $(".players").html("");
    data.ranking.slice(0, 20).map((item, index) => {
      $(".players").append(`       
        <div class="player">
          <p>${index + 1}°</p>
          <p>${item.name}</p>
          <p>${item.qtd} <b>CHAMADOS</b></p>
        </div>                 
      `);
    });
    // document.querySelector('.my').innerHTML = `
    //   <h3>SUA POSIÇÃO</h3>
    //   <div class="player">
    //     <p>${userPosition}°</p>
    //     <p>${userProps.name}</p>
    //     <p>${userProps.qtd} <b>CHAMADOS</b></p>
    //   </div>
    // `
    document.body.style.display = 'flex'
  } else {
    document.body.style.display = 'none'
  }
})