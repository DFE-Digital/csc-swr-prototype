require.context('govuk-frontend/govuk/assets');

import '../styles/application.scss';
import Rails from 'rails-ujs';
import Turbolinks from 'turbolinks';
import { initAll } from 'govuk-frontend';

// if ('serviceWorker' in navigator) {
//   window.addEventListener('load', function() {
//     navigator.serviceWorker.register('service_worker.js', { scope: "/" })
//       .then(function(registration) {
//         console.log('[ServiceWorker Client]', 'registration successful with scope: ', registration.scope);
//       }, function(err) {
//         console.log('[ServiceWorker Client]', 'registration failed: ', err);
//       });
//   });
// }

Rails.start();
Turbolinks.start();
initAll();
