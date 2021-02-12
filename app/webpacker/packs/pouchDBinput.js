// This will alert the user a change to their network connectivity
window.addEventListener('load', function() {
  function updateOnlineStatus(event) {
    var condition = navigator.onLine ? "online" : "offline";
    alert(`you are ${condition}`)
  }
  window.addEventListener('online',  updateOnlineStatus);
  window.addEventListener('offline', updateOnlineStatus);
});

// You can use the localStorage adapter is support for old browsers, use { adapter: 'localStorage' }
// as a second argument to instantiation of new pouch
let localdb = new PouchDB('social_worker_recording_tool_local')
let remotedb = new PouchDB('http://admin:password@127.0.0.1:5984/social_worker_recording_tool_remote');

const sync = localdb.sync(remotedb, {  
  live: true,  
  retry: true  
}).on('change', function (change) {
  console.log('Something changed!!')
}).on('paused', function (info) {
  console.log('Replication was paused. Probably because of lost connection')
}).on('active', function (info) {
  console.log('Replication was resumed!!!')
})

$("#submit_button").on("click", function() {
  let input_data = $("#form_input").val()
  addItemToDb(input_data)
})

function addItemToDb(text) {
  let visit_note = {
    _id: new Date().toISOString(),
    content: text
  }
  localdb.put(visit_note, function callback(err, result) {
    if (!err) {
      console.log('Successful addition of visit note into PouchDB!')
    } else {
      console.log(err)
    }
  })
}

// This will replicate the localdb to the remote db if something changes
localdb.replicate.to(remotedb).on('complete', function() {
  console.log('Replication complete')
}).on('error', function(err) {
  console.log('An error!!!!!!!', err)
})

// Step 4: Listen to the changes. 
remotedb.changes().on('change', () => {
  console.log('Changes')
})