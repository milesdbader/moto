import "bootstrap";
import { setupProfileChallengeEvents } from '../plugins/profile-page'

// Are there challenge results on the page (on the PROFILE page)?
const challengeResults = document.querySelector('.profile-challenge-result')
if (challengeResults) {
  setupProfileChallengeEvents()
}
import { wieSweetalertChallengeReject, wireSweetalertNoVotes } from "../plugins/swal.js"

wireSweetalertChallengeReject();
wireSweetalertNoVotes();
