document.addEventListener('keydown', function(event) {
    const category_container = document.querySelector('.website-types-container');

    if (event.key === "c") {
        if (category_container) {
            if (category_container.style.display === 'flex') {
                category_container.style.display = 'none';
            } else {
                category_container.style.display = 'flex';
            }
        }
    }
});

// hide footer on /random page
const footer = document.getElementById("footer");
if (window.location.pathname === '/random') {
    //console.log(footer);
    if (footer) {
        footer.style.display = "none";
    }
}
else {
    if (footer) {
        footer.style.display = "block";
    }
}

        
