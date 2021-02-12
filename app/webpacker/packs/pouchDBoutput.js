let localdb = new PouchDB('social_worker_recoding_tool_local_database');
let remotedb = new PouchDB('http://admin:password@127.0.0.1:5984/social_worker_recording_tool_remote');

const sync = localdb.sync(remotedb, {  
  live: true,  
  retry: true  
}).on('paused', () => {
  console.log('hello from inside paused')
  localdb.allDocs({
    include_docs: true,
    attachments: true
  }).then((response) => {
    let output 
    response.rows.forEach((row) => {
      output += "<p>" + row.doc.content + "</p>"
    })
    $("div#output").html(output)
  })
})

remotedb.changes({
  live: true, 
  retry: true
}).on('change', () => {
  console.log('We have experienced a change in the REMOTE db!!!!')
})