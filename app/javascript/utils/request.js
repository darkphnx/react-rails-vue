// Set some sensible defaults for axios such as content types and scrape the csrf token from the page

import axios from 'axios';

function csrfToken() {
  const metaTag = document.querySelector('meta[name="csrf-token"]')
  if(metaTag) {
    return metaTag.getAttribute('content');
  }
}

export default axios.create({
  baseURL: '/',
  headers: {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'X-CSRF-Token': csrfToken()
  }
});
