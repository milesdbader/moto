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
const wireSweetalertChallengeReject = () => {
  document.querySelectorAll('.btn-challenge-cancel').forEach((btn) => {
    const challengeId = btn.dataset.challengeId;
    const selector = `.btn-challenge-cancel[data-challenge-id="${challengeId}"`;
    const callback = (value) => {
      if (value) {
        const link = btn.parentElement.querySelector('.reject-link');
        link.click();
        // console.log('about to click: ')
        // console.log(link)
      }
    }

    initSweetalert(selector,
      {
        title: "Reject this challenge?",
        text: "This action cannot be reversed",
        buttons: [true, "Reject it!"]
      },
      callback
    )
  })
}

const wireSweetalertNoVotes = () => {
  initSweetalert('#vote-button-no-votables',
    {
      title: "Nothing to vote on!",
      text: "There are no challenges on the chopping block now. Check back soon :)"
    }
  )
}
export { wireSweetalertChallengeReject, wireSweetalertNoVotes }
