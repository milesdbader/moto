import swal from 'sweetalert';

const initSweetalert = (selector, options = {}, callback = () => {}) => {
  const swalButton = document.querySelector(selector);
  if (swalButton) { // protect other pages
    swalButton.addEventListener('click', () => {
      swal(options).then(callback);
    });
  }
};


// Setup Sweet Alert for 'cancel challenge' buttons
document.querySelectorAll('.btn-challenge-cancel').forEach((btn) => {
  const challengeId = btn.dataset.challengeId;
  const selector = `.btn-challenge-cancel[data-challenge-id="${challengeId}"`;
  const callback = (value) => {
    if (value) {
      const link = btn.parentElement.querySelector('.reject-link');
      // link.click();
      console.log('about to click: ')
      console.log(link)
    }
  }

  initSweetalert(selector,
    {
      title: "Are you sure?",
      text: "This action cannot be reversed",
      icon: "warning"
    },
    callback
  )
})
