const game_query_button = document.getElementById('game-query');
const simulation_query_button = document.getElementById('simulation-query');
const puzzle_query_button = document.getElementById('puzzle-query');
const music_query_button = document.getElementById('music-query');
const art_query_button = document.getElementById('art-query');
const all_query_button = document.getElementById('all-query');
const all_buttons = [game_query_button, simulation_query_button, puzzle_query_button, music_query_button, art_query_button, all_query_button];

const website_frame = document.getElementById("website-frame");

function close_popup() {
  const category_container = document.querySelector('.website-types-container');
  if (category_container) category_container.style.display = 'none';
}

// Decide which API endpoint to call for a given category
function endpointFor(category) {
  return category === 'all' ? '/api/random' : `/api/random/${encodeURIComponent(category)}`;
}

all_buttons.forEach((button) => {
  if (!button) return;

  button.addEventListener('click', async () => {
    try {
      // get category from button pressed
      const category = button.id.replace(/-query$/, '');
      console.log('User Clicked on ' + category);

      const endpoint = endpointFor(category);

      // get a random URL from the server
      const resp = await fetch(endpoint); // response
      if (!resp.ok) { // check http status
        console.error('Fetch failed:', resp.status, resp.statusText);
        return;
      }
    
      const data = await resp.json();
      if (!data.url) {
        console.error('No url in response');
        return;
      }

      if (website_frame) { // on random page, only update iframe
        website_frame.src = data.url;

      } else { // If on another page load /random with ifram based on category
        window.location.href = `/random?site=${encodeURIComponent(data.url)}&category=${encodeURIComponent(category)}`;
      }
    } catch (err) {
      console.error('Error:', err);
    } 

    close_popup();

  });
});
