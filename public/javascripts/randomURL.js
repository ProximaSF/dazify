// Ensure the DOM is fully loaded before executing scripts
if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", loadRandomSite);
} else {
    loadRandomSite();
}


// Load a random site into the iframe
const website_frame = document.getElementById("website-frame");
function loadRandomSite() {
    fetch('/api/random')
        .then(response => response.json())
        .then(data => {
            if (data.url) {
                website_frame.src = data.url;
            }
        });
}

// Load a new random site on click
document.addEventListener("DOMContentLoaded", function() {
    const daze_image = document.getElementById("daze-image");

    if (daze_image && website_frame) {
        daze_image.addEventListener("click", function() {
            fetch('/api/random')
                .then(response => response.json())
                .then(data => {
                    if (data.url) {
                        //console.log("Loading URL:", data.url);
                        website_frame.src = data.url;
                    }
                });
        });
    }
});