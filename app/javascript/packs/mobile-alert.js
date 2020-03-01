import swal from 'sweetalert';

const switchToMobileFlash = () => {
  swal({
    title: 'Welcome!',
    text: 'This site was optimized for use on mobile devices; please consider switching.',
    buttons: [false, false]
  });
}

switchToMobileFlash();
