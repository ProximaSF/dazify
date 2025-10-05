const option_buttons = document.getElementById("daze-menu-button");
const menu = document.getElementById("daze-menu-container");

// Function to move menu
function moveMenu(value) {
    document.documentElement.style.setProperty('--menu-initial-pos', value);
}

// Evebt listeners for menu interactions
if (option_buttons) {
    option_buttons.addEventListener("click", function() {
        //console.log("Option button clicked");
        //console.log(getComputedStyle(document.documentElement).getPropertyValue('--menu-left'));
        moveMenu('0%');
    });
}

// Close menu when mouse leaves
menu.addEventListener("mouseleave", function(){
    moveMenu('-30%');
});


// Remove banner
const removeBannerButton = document.querySelector("#daze-menu-container a[href='#']");
const removeBanner = document.getElementById("remove-banner");
const website_frame = document.getElementById("website-frame")
if (removeBannerButton && removeBanner) {
    removeBannerButton.addEventListener("click", function(event) {
        event.preventDefault(); // Prevent default link behavior
        const current_ifram_url = website_frame.src;
        window.location.href = current_ifram_url;
    });
}