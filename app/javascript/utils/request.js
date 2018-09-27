// Set some sensible defaults for axios such as content types and scrape the csrf token from the page

import axios from 'axios';

const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

export default axios.create({
  baseURL: '/',
  headers: {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'X-CSRF-Token': csrfToken
  }
});
