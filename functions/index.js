const functions = require("firebase-functions");
const admin = require('firebase-admin');
admin.initializeApp();

const firestore = admin.firestore();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
exports.helloWorld = functions.https.onRequest((request, response) => {
    functions.logger.info("Hello logs!", { structuredData: true });
    response.send("Hello from Firebase!");
});

exports.getSong = functions.https.onCall(async (data, context) => {
    const snap = await firestore.collection('songs').doc(data.id).get();
    return snap.data();
});

exports.getArtist = functions.https.onCall(async (data, context) => {
    const snap = await firestore.collection('artists').doc(data.id).get();
    return snap.data();
});

exports.getRandomSong = functions.https.onCall(async (data, context) => {
    const collectionSnap = await firestore.collection('songs').get();
    const randomIndex = Math.floor(Math.random() * collectionSnap.size);

    return collectionSnap.docs[randomIndex].data();
});