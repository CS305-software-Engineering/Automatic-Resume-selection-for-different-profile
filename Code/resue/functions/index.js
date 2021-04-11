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




        await db.collection('Resumes').doc().set({ 'Id':s })
            .then(function (docRef) {

            }).catch(function (error) {
                console.error("Error adding document: ", error);
            });



    context.send(200);


}

exports.scheduleAppointment = functions.https.onRequest((req, res) => scheduleAppointment(req, res))




setInterval(() => { }, 1000);