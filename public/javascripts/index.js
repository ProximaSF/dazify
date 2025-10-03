// Check element center
const main_conatiner = document.querySelector('.main-container');

console.log(main_conatiner)

const rect = main_conatiner.getBoundingClientRect();

const viewportWidth = window.innerWidth;
const viewportHeight = window.innerHeight;

const elementCenterX = rect.left + rect.width / 2;
const elementCenterY = rect.top + rect.height / 2;

const viewportCenterX = viewportWidth / 2;
const viewportCenterY = viewportHeight / 2;

const tolerance = 5; // Pixels

const isCenteredHorizontally = Math.abs(elementCenterX - viewportCenterX) <= tolerance;
const isCenteredVertically = Math.abs(elementCenterY - viewportCenterY) <= tolerance;

const isCentered = isCenteredHorizontally && isCenteredVertically;

if (isCentered) {
  console.log("Element is centered on the screen.");
} else {
  console.log("Element is not centered on the screen.");
};