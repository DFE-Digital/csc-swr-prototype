// // Use feature-detection to check for ES6 support.
// function browserSupportsES6() {
//   try { eval("var foo = (x)=>x+1"); }
//   catch (e) { return false; }
//   return true;
// }

// // Use service workers only if the browser supports ES6,
// // the Cache API and of course Service Workers themselves.
// if (browserSupportsES6() && ('caches' in window) && ('serviceWorker' in navigator)) {
//   navigator.serviceWorker.register('/service-worker.js', { scope: '/' })
//   .then(function(reg) {
//     console.log('Service worker registration succeeded!');
//   }).catch(function(error) {
//     console.log('Service worker registration failed: ' + error);
//   });
// }

// Make sure sw are supported
if('serviceWorker' in navigator) {
  window.addEventListener('load', () => {
    navigator.serviceWorker
      .register('/service-worker.js')
      .then(reg => console.log('Service Worker: Registered'))
      .catch(err => console.log(`Service Worker: Error: ${err}`))
  })
}