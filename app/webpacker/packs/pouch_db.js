// The below code was originally in the visit_note view to persist data in localStorage
// $(document).ready(function() {
//   $('#form_input').val(localStorage.getItem('Example Form'))
// });
// setInterval(() => {
//   localStorage.setItem('Example Form', document.getElementById("form_input").value)
// }, 5000)


function addItemToDb(text) {
  console.log('hello')
  let visit_note = {
    _id: new Date().toISOString(),
    content: text
  }
  db.put(visit_note, function callback(err, result) {
    if (!err) {
      console.log('Successful addition of visit note into PouchDB!')
    }
  })
}

// Step 3: replicate to the server
db.replicate.to('http://localhost:3000/visit-notes')

// Step 4: Listen to the changes
db.changes().on('change', () => {
  console.log('Changes')
})