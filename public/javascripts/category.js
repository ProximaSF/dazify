const category_button = document.getElementById('category-button');
const category_container = document.querySelector('.website-types-container');

if (category_button) {
    category_button.addEventListener('click', function() {
        console.log(category_container)
        category_container.style.display = 'flex'

    })
}


// Close popup
const close_button = document.getElementById('close-button')
if (close_button) {
    close_button.addEventListener('click', function() {
        category_container.style.display = 'none'
    })
}


document.addEventListener("keydown", function() {
    if (event.key === "Escape") {
        category_container.style.display = 'none'
    }
})

