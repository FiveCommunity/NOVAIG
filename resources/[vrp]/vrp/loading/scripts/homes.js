const images = ['home1', 'home2', 'home3', 'POSTE1', 'POSTE2']
let imagesLoaded = -1

function ResetAllImages() {
  for (const image of images) {
    document.getElementById(image).style.display = 'none'
  }
}

document.body.addEventListener('click', function() {
  if (imagesLoaded === images.length - 1) {
    ResetAllImages()
    imagesLoaded = -1
  }
  imagesLoaded += 1

  const element = document.getElementById(images[imagesLoaded])
  element.style.display = 'block'
  
})

setInterval(() => {
  document.body.dispatchEvent(new Event('click'))
}, 2000)