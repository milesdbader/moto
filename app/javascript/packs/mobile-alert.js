import swal from 'sweetalert';

const switchToMobileFlash = () => {
  swal({
    title: 'Welcome!',
    text: 'This site was optimized for use on mobile devices; please consider switching.',
    buttons: [false, false]
  });
}

let visited = sessionStorage.getItem('visited');

if(visited === null){
  switchToMobileFlash();
  sessionStorage.setItem('visited', true)
}

