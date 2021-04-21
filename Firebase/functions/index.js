const functions = require("firebase-functions");
var admin = require('firebase-admin');

admin.initializeApp({
    credential: admin.credential.applicationDefault(),
    databaseURL: 'https://first-outlet-307908.firebaseio.com'
});
const db = admin.firestore();
var firebaseDatabase = admin.firestore();
var dept = { 'One': 0, 'General Surgery': 1, 'Dermatology,Venereology and leprology': 2, 'Gynaecology': 3, 'Internal Medicine': 4, 'Obstetrics(For Pregnant Women)': 5, 'Ophthalmology(EYE)': 6, 'Oral Health Sciences Center(Dental)': 7, 'Orthopaedics': 8, 'Paediatrics Orthopaedics': 9, 'Paediatric Surgery': 10, 'Paediatric Medicine': 11, 'Plastic Surgery': 12, 'Urology': 13 };

var presum = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];



async function scheduleAppointment(snap, context) {
    var s = snap.query.name;
    var email = s.split('|')[0];
    var dl = s.split('|')[2];
    month = "";
    var str = "";
    str = str + s[email.length + 9] + s[email.length + 10];
    month = month + s[email.length + 6] + s[email.length + 7];
    var months = parseInt(month);
    var Dat = parseInt(str);
    var booked_day = Dat + parseInt(presum[months - 1]);
    var uniqueId, current_doc;
    var output;


    await db.collection('current_doc').doc('doc_id').get()
        .then(function (docRef) {
            current_doc = docRef.data().curr_doc;
            console.log('Current Doc: ' + current_doc);
        })
        .catch(function (error) {
            console.error('Error adding document: ' + error);
        });



    var d = new Date();
    var curr_day = d.getDate() + parseInt(presum[d.getMonth()]);

    console.log('current_doc no:  ' + current_doc);
    console.log(booked_day);
    console.log(curr_day);
    console.log(s);
    await db.collection('Users').doc(email).collection('appointments').doc().set({ 'dep': dl, 'date': booked_day })
        .then(function (docRef) {

        }).catch(function (error) {
            console.error("Error adding document: ", error);
        });

    if ((booked_day - curr_day + parseInt(current_doc)) % 7 == 0) {
        console.log("in ifff");

        var path6 = dl + '/7/' + 'patients';
        const collectionLast6 = db.collection(path6).doc('curr_ind');

        const doc6 = await collectionLast6.get();

        if (!doc6.exists) {
            await db.collection(dl).doc('7').collection('patients').doc('curr_ind').set({ "index": 0 })
                .then(function (docRef) {
                    console.log("nurr_ind set to 0 initially");
                })
                .catch(function (error) {
                    console.error("Error in setting curr_ind index to 0: ", error);
                });
        }


        var currInd;

        await db.collection(dl).doc('7').collection('patients').doc('curr_ind').get()
            .then(function (docRef) {
                currInd = parseInt(docRef.data().index);
                console.log("currInd: " + currInd);
            })
            .catch(function (error) {
                console.error("Error index: ", error);
            });

        const data = {
            "name": email,
            "index": currInd + 1,
            "createdAt": admin.firestore.Timestamp.now()
        };
        console.log('data before adding' + JSON.stringify(data));


        await db.collection(dl).doc('7').collection('patients').doc('curr_ind').update({ "index": (currInd + 1) }).then(function (docRef) {
            // console.log('Added document: ' + JSON.stringify(docRef));
        }).catch(function (error) {
            console.error("Error adding document: ", error);
        });


        //output = current_d1["tot"] + 1;

        await db.collection(dl).doc('7').collection('patients').doc().set(data)
            .then(function (docRef) {
                console.log('Patient_id: ' + docRef.patient_id);
                console.log('created at' + "  " + docRef.createdAt);
            })
            .catch(function (error) {
                console.error("Error adding document: ", error);
            });

    }
    else {

        var booking = (booked_day - curr_day + parseInt(current_doc)) % 7;
        var index = booking.toString();

        var path6 = dl + '/' + index + '/' + 'patients';
        const collectionLast6 = db.collection(path6).doc('curr_ind');

        const doc6 = await collectionLast6.get();

        if (!doc6.exists) {
            await db.collection(dl).doc(index).collection('patients').doc('curr_ind').set({ "index": 0 })
                .then(function (docRef) {
                    console.log("nurr_ind set to 0 initially");
                })
                .catch(function (error) {
                    console.error("Error in setting curr_ind index to 0: ", error);
                });
        }
        var currInd;
        console.log('index value:  ' + index);
        await db.collection(dl).doc(index).collection('patients').doc('curr_ind').get()
            .then(function (docRef) {
                currInd = docRef.data().index;
                console.log("currInd: " + currInd);
            })
            .catch(function (error) {
                console.error("Error index: ", error);
            });

        const data = {
            "name": email,
            "index": currInd + 1,
            "createdAt": admin.firestore.Timestamp.now()
        };
        console.log('data before adding' + JSON.stringify(data));


        await db.collection(dl).doc(index).collection('patients').doc('curr_ind').set({ "index": (currInd + 1) }).then(function (docRef) {
            // console.log('Added document: ' + JSON.stringify(docRef));
        }).catch(function (error) {
            console.error("Error adding document: ", error);
        });

        await db.collection(dl).doc(index).collection('patients').doc().set(data).then(function (docRef) {
            console.log('Added document: ' + JSON.stringify(docRef));
        })
            .catch(function (error) {
                console.error("Error adding document: ", error);
            });

    }
    context.sendStatus(200);
    return;


}

async function cancelAppointment(snap, context) {
    var s = snap.query.name;
    var email = s.split('|')[0];
    var dl = s.split('|')[2];
    month = "";
    var str = "";
    str = str + s[email.length + 9] + s[email.length + 10];
    month = month + s[email.length + 6] + s[email.length + 7];
    var months = parseInt(month);
    var Dat = parseInt(str);
    var booked_day = Dat + parseInt(presum[months - 1]);
    var uniqueId, current_doc;
    var d = new Date();
    var curr_day = d.getDate() + parseInt(presum[d.getMonth()]);
    // search and delete

    await db.collection('current_doc').doc('doc_id').get()
        .then(function (docRef) {
            current_doc = docRef.data().curr_doc;
            console.log('Current Doc: ' + current_doc);
        })
        .catch(function (error) {
            console.error('Error adding document: ' + error);
        });
    if ((booked_day - curr_day + parseInt(current_doc)) % 7 == 0) {
        console.log("in ifff");

        var path2 = dl + '/7/' + 'patients';
        var ref = db.collection(path2);

        var collectionLast = ref.where("name", '==', (email.toString()));
        var collec2;

        var del_time;
        await collectionLast.get().then(async function (querySnapshot) {
            querySnapshot.forEach(async function (doc) {

                del_time = doc.ref.data().createdAt;
                doc.ref.delete();
                collec2 = ref.where("createdAt", '>', del_time);
                await collec2.get().then(async function (querySnapshot) {
                    querySnapshot.forEach(async function (doc) {
                        var curr_index = doc.ref.data().index;
                        await doc.ref.update("index", curr_index - 1);
                    })
                });

            });
        });

        var curr_ind1;
        await db.collection(dl).doc(index).collection('patients').doc('curr_ind').get()
            .then(async function (docRef) {
                curr_ind1 = docRef.data().index;
                await db.collection(dl).doc(index).collection('patients').doc('curr_ind').set({ "index": (curr_ind1 - 1) }).then(function (docRef) {
                }).catch(function (error) {
                    console.error("Error adding document: ", error);
                });
            })
            .catch(function (error) {
                console.error("Error index: ", error);
            });


    }
    else {

        var booking = (booked_day - curr_day + parseInt(current_doc)) % 7;

        var index = booking.toString();
        console.log("in else");
        console.log(booked_day);
        console.log(curr_day);
        console.log(email.toString());


        var path2 = dl + '/' + index + '/' + 'patients';
        var ref = db.collection(path2);

        var collectionLast = ref.where("name", '==', (email.toString()));
        var collec2;

        var del_time;
        await collectionLast.get().then(async function (querySnapshot) {
            querySnapshot.forEach(async function (doc) {
                console.log('$$');
                console.log(JSON.stringify(doc.data()));
                del_time = doc.data().createdAt;
                await doc.ref.delete();
                collec2 = ref.where("createdAt", '>', del_time);
                await collec2.get().then(async function (querySnapshot) {
                    console.log('##');
                    console.log(JSON.stringify(doc.data()));
                    querySnapshot.forEach(async function (doc) {
                        console.log('%%');
                        var curr_index = doc.data().index;
                        console.log('current_index:  ' + curr_index);
                        await doc.ref.update("index", curr_index - 1);
                    })
                });

            });
        });

        var curr_ind1;
        await db.collection(dl).doc(index).collection('patients').doc('curr_ind').get()
            .then(async function (docRef) {
                curr_ind1 = docRef.data().index;
                await db.collection(dl).doc(index).collection('patients').doc('curr_ind').set({ "index": (curr_ind1 - 1) }).then(function (docRef) {
                }).catch(function (error) {
                    console.error("Error adding document: ", error);
                });
            })
            .catch(function (error) {
                console.error("Error index: ", error);
            });

    }


    context.sendStatus(200);
    return;
}

async function popAppointment(snap, context) {
    var s = snap.query.name;
    var email = s.split('|')[0];
    var dl = s.split('|')[2];
    month = "";
    var str = "";
    str = str + s[email.length + 9] + s[email.length + 10];
    month = month + s[email.length + 6] + s[email.length + 7];
    var months = parseInt(month);
    var Dat = parseInt(str);
    var booked_day = Dat + parseInt(presum[months - 1]);
    var uniqueId, current_doc;
    var d = new Date();
    var curr_day = d.getDate() + parseInt(presum[d.getMonth()]);
    var booking = (booked_day - curr_day + parseInt(current_doc)) % 7;
    console.log('booking and current day');
    console.log(booked_day);
    console.log(curr_day);
    var index = booking.toString();



    await db.collection('current_doc').doc('doc_id').get()
        .then(function (docRef) {
            current_doc = docRef.data().curr_doc;
            console.log('Current Doc: ' + current_doc);
        })
        .catch(function (error) {
            console.error('Error adding document: ' + error);
        });

    var currInd;
    await db.collection(dl).doc(current_doc).collection('patients').doc('curr_ind').get()
        .then(async function (docRef) {
            currInd = docRef.data().index;
            console.log("currInd: " + currInd.toString());
        })
        .catch(function (error) {
            console.error("Error index: ", error);
        });



    // first element of document ordered by timestamp
    console.log("dep: " + dl);
    console.log("curr_doc: " + current_doc);
    console.log("dep: " + dl);


    var path2 = dl + '/' + current_doc + '/' + 'patients';
    var ref = db.collection(path2);

    var del_time;
    var collec2;
    var collectionLast = ref.orderBy("createdAt").limit(1);
    await db.collection(dl).doc(current_doc).collection('patients').doc('curr_ind').get()
        .then(async function (docRef) {
            currInd = docRef.data().index;
            console.log("currInd: " + currInd);
        })
        .catch(function (error) {
            console.error("Error index: ", error);
        });
    collectionLast.get().then(async function (querySnapshot) {
        querySnapshot.forEach(async function (doc) {
            console.log('$$');
            console.log(JSON.stringify(doc.data()));
            del_time = doc.data().createdAt;
            await doc.ref.delete();
            console.log('current indexxxxx:  ' + currInd.toString())
            var temp1 = currInd - 1;
            console.log('current indexxxxx111: ' + temp1.toString());

            await db.collection(dl).doc(current_doc).collection('patients').doc('curr_ind').set({ "index": temp1 }).then(function (docRef) {
                console.log('index value changed');
            }).catch(function (error) {
                console.error("Error adding document: ", error);
            });
            collec2 = ref.where("createdAt", '>', del_time);
            collec2.get().then(async function (querySnapshot) {
                console.log('##');
                console.log(JSON.stringify(doc.data()));
                querySnapshot.forEach(async function (doc) {
                    console.log('%%');
                    var curr_index = doc.data().index;
                    console.log('current_index:  ' + curr_index);
                    await doc.ref.update("index", curr_index - 1);
                })
            });

        });
    });


    context.sendStatus(200);
    return;
}

async function waiting_queue(snap, context) {
    var s = snap.query.name;
    var email = s.split('|')[0];
    var dl = s.split('|')[2];
    month = "";
    var str = "";
    str = str + s[email.length + 9] + s[email.length + 10];
    month = month + s[email.length + 6] + s[email.length + 7];
    var months = parseInt(month);
    var Dat = parseInt(str);
    var booked_day = Dat + parseInt(presum[months - 1]);
    var uniqueId, current_doc;
    var d = new Date();
    var curr_day = d.getDate() + parseInt(presum[d.getMonth()]);

    await db.collection('current_doc').doc('doc_id').get()
        .then(function (docRef) {
            current_doc = docRef.data().curr_doc;
            console.log('Current Doc: ' + current_doc);
        })
        .catch(function (error) {
            console.error('Error adding document: ' + error);
        });

    // first element of document ordered by timestamp


    var path2 = dl + '/' + current_doc + '/' + 'patients';
    var ref = db.collection(path2);
    var current_d;


    var collectionLast = ref.orderBy("createdAt").limit(1);
    await collectionLast.get().then(function (querySnapshot) {
        querySnapshot.forEach(function (doc) {

            console.log('$$');
            doc.ref.get().then(async function (docRef) {
                current_d = docRef.data();
                var path3 = dl + '/' + current_doc + '/' + 'waiting_queue';
                console.log('**');
                console.log('current_d:  ' + JSON.stringify(current_d));
                await db.collection(path3).doc().set(current_d).then(function (docRef) {
                    console.log('Added document: ' + JSON.stringify(collectionLast));
                })
                    .catch(function (error) {
                        console.error("Error adding document: ", error);
                    });

                await popAppointment(snap, context);

            })
                .catch(function (error) {
                    console.error('Error adding document: ' + error);
                });

        });
    });


    // adding data to waiting queue



    context.sendStatus(200);
    return;
}


async function pushtoReadyQueue(snap, context) {
    var s = snap.query.name;
    var email = s.split('|')[0];
    var dl = s.split('|')[2];
    month = "";
    var str = "";
    str = str + s[email.length + 9] + s[email.length + 10];
    month = month + s[email.length + 6] + s[email.length + 7];
    var months = parseInt(month);
    var Dat = parseInt(str);
    var booked_day = Dat + parseInt(presum[months - 1]);
    var uniqueId, current_doc;
    var d = new Date();
    var curr_day = d.getDate() + parseInt(presum[d.getMonth()]);

    await db.collection('current_doc').doc('doc_id').get()
        .then(function (docRef) {
            current_doc = docRef.data().curr_doc;
            console.log('Current Doc: ' + current_doc);
        })
        .catch(function (error) {
            console.error('Error adding document: ' + error);
        });

    var booking = (booked_day - curr_day + parseInt(current_doc)) % 7;
    var index = booking.toString();
    var path2 = dl + '/' + current_doc + '/' + 'waiting_queue';
    var ref = db.collection(path2);
    var path7 = dl + '/' + current_doc + '/' + 'patients';
    var ref1 = db.collection(path7);

    var collectionLast = ref.where("name", '==', (email.toString()));
    var collec2;

    var del_time;
    var current_d;
    await collectionLast.get().then(async function (querySnapshot) {
        var qlen = querySnapshot.size;
        console.log('length');
        console.log(qlen);
        querySnapshot.forEach(async function (doc) {
            console.log('$$');
            console.log(JSON.stringify(doc.data()));
            del_time = doc.data().createdAt;
            current_d = doc.data();
            var path3 = dl + '/' + current_doc + '/' + 'patients';
            console.log('**');

            await db.collection(path3).doc().set(current_d).then(function (docRef) {
                console.log('Added document to patients: ' + JSON.stringify(collectionLast));
            })
                .catch(function (error) {
                    console.error("Error adding document: ", error);
                });

            await doc.ref.delete();

            collec2 = ref1.where("createdAt", '>', del_time);
            await collec2.get().then(async function (querySnapshot) {
                console.log('##');
                console.log(JSON.stringify(doc.data()));
                querySnapshot.forEach(async function (doc) {
                    console.log('%%');
                    var curr_index = doc.data().index;
                    console.log('current_index:  ' + curr_index);
                    await doc.ref.update("index", curr_index + 1);
                })
            });

        });
        var curr_ind1;
        if (qlen) {
            await db.collection(dl).doc(current_doc).collection('patients').doc('curr_ind').get()
                .then(function (docRef) {
                    curr_ind1 = docRef.data().index;
                    db.collection(dl).doc(current_doc).collection('patients').doc('curr_ind').set({ "index": (curr_ind1 + 1) }).then(function (docRef) {
                    }).catch(function (error) {
                        console.error("Error adding document: ", error);
                    });
                })
                .catch(function (error) {
                    console.error("Error index: ", error);
                });
        }
        if (!qlen) {
            console.log('No data found in waiting queue...');
        }
    });




    context.sendStatus(200);
    return;
}


exports.fun_caller = functions.https.onRequest(async (req, res) => {
    var q = req.query.name;
    console.log("request:  " + req);
    console.log("query:   " + q);
    var control = parseInt(q.split('|')[3]);
    console.log("control:   " + control);
    switch (control) {
        case 1:
            scheduleAppointment(req, res);
            break;
        // case 2:
        //     showAppointment(req, res);
        //     break;
        case 3:
            popAppointment(req, res);
            break;
        case 4:
            waiting_queue(req, res);
            break;
        case 5:
            cancelAppointment(req, res);
            break;
        case 6:
            pushtoReadyQueue(req, res);

    }

});