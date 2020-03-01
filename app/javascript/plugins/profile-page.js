const setupProfileChallengeEvents = () => {
  const userAvatars = document.querySelectorAll(".profile-challenge-result .avatar");
  userAvatars.forEach((avatar) => {
    avatar.addEventListener('click', (event) => {
      const avatarContainer = avatar.parentElement.parentElement

      // Don't toggle highlights if we're clicking an active avatar
      if (!avatar.classList.contains('prof-active')) {
        avatarContainer.querySelectorAll('.avatar').forEach((avatar) => {
          avatar.classList.toggle('prof-active')
        })
      }

      // Get user id from clicked avatar
      const userId = avatar.dataset.userId

      // Send all images for this challenge to the back
      avatarContainer.parentElement.querySelectorAll('.profile-food').forEach((img) => {
        img.classList.remove('top-img')
      })

      // Find the image with this user id and bring it forward
      const userRecipeImage = avatarContainer.parentElement.querySelector(
        `.profile-food[data-user-id="${userId}"]`)
      userRecipeImage.classList.add('top-img')
    });
  });
}

export { setupProfileChallengeEvents }
