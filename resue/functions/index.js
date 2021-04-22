const functions = require("firebase-functions");
var admin = require('firebase-admin');

admin.initializeApp({
    credential: admin.credential.applicationDefault(),
    databaseURL: 'https://resume-b5075.firebaseio.com'
});
const db = admin.firestore();
var firebaseDatabase = admin.firestore();
var dept = { 'One': 0, 'General Surgery': 1, 'Dermatology,Venereology and leprology': 2, 'Gynaecology': 3, 'Internal Medicine': 4, 'Obstetrics(For Pregnant Women)': 5, 'Ophthalmology(EYE)': 6, 'Oral Health Sciences Center(Dental)': 7, 'Orthopaedics': 8, 'Paediatrics Orthopaedics': 9, 'Paediatric Surgery': 10, 'Paediatric Medicine': 11, 'Plastic Surgery': 12, 'Urology': 13 };

var presum = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];

async function scheduleAppointment(snap, context) {
    var s = snap.query.name;
    var email = s.split('|')[0];
    var job_des = s.split('|')[1];
    var job_summary = s.split('|')[2];
    console.log(email);
    console.log(job_des);
    console.log(job_summary);
        await db.collection(email).doc('TOTAL').get()
                                                              .then(function (docRef) {
                                                                      currNum = parseInt(docRef.data().tot);
                                                                      console.log("currNum: " + currNum);
                                                                  })
                                                                  .catch(function (error) {
                                                                      console.error("Error adding document: ", error);
                                                                  });

        await db.collection(email).doc('TOTAL').update({ 'tot':currNum+1 })
            .then(function (docRef) {

            }).catch(function (error) {
                console.error("Error adding document: ", error);
            });

        var jobid = "jobno"+currNum;
        await db.collection(email).doc('posted_jobs').collection('jobs').doc(jobid).set({ 'job_desc':job_des ,'jobid':jobid,'job_summary':job_summary,'CLIENT_id':email})
            .then(function (docRef) {

            }).catch(function (error) {
                console.error("Error adding document: ", error);
            });
 await db.collection('posted_jobs').doc().set({ 'job_desc':job_des ,'jobid':jobid,'job_summary':job_summary,'CLIENT_id':email})
            .then(function (docRef) {

            }).catch(function (error) {
                console.error("Error adding document: ", error);
            });



    context.send(200);


}

exports.scheduleAppointment = functions.https.onRequest((req, res) => scheduleAppointment(req, res))


async function user(snap, context) {
    var s = snap.query.name;
        var nam = s.split('|')[0];

        var phoneNumber = s.split('|')[1];
        var tenth = s.split('|')[2];

        var _twelfth = s.split('|')[3];
        var  _gap = s.split('|')[4];
        var _tier= s.split('|')[5];
        var _cgpa = s.split('|')[6];
        var _branch = s.split('|')[7];
        var des = s.split('|')[8];
        var email = s.split('|')[9]


        await db.collection('students').doc(email).set({ 'name': nam,'phoneNumber':phoneNumber,'tenth':tenth,'twelfth' : _twelfth, 'gap' : _gap, 'tier' : _tier, 'cgpa' : _cgpa, 'branch' : _branch,'details':des })
            .then(function (docRef) {

            }).catch(function (error) {
                console.error("Error adding document: ", error);
            });



    context.send(200);


}

exports.user = functions.https.onRequest((req, res) => user(req, res))


async function user1(snap, context) {
       var s = snap.query.name;
       var job_id,client_id;
       job_id = s.split('|')[0];
       client_id = s.split('|')[1];
       email = s.split('|')[2];
            var index;
        var resume;
        console.log(job_id)
        console.log(client_id)


          await db.collection('students').doc(email).get()
                    .then(function (docRef) {
                        resume= docRef.data();
                    }).catch(function (error) {
                        console.error("Error adding document: ", error);
                    });


  await db.collection(client_id).doc('posted_jobs').collection('jobs').doc(job_id).collection('applied_people').doc(email).set({ 'name': resume.name,'phoneNumber':resume.phoneNumber,'tenth':resume.tenth,'twelfth' : resume.twelfth, 'gap' : resume.gap, 'tier' : resume.tier, 'cgpa' : resume.cgpa, 'branch' : resume.branch,'details':resume.details ,'similarity':0})
            .then(function (docRef) {

            }).catch(function (error) {
                console.error("Error adding document: ", error);
            });

    context.send(200);


}
exports.user1 = functions.https.onRequest((req, res) => user1(req, res))




setInterval(() => { }, 1000);