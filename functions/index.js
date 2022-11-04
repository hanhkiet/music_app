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

exports.getTrendingSongs = functions.https.onCall(async (data, context) => {
    const snap = await firestore.collection('songs').orderBy('play_count', 'desc').limit(5).get();
    const result = snap.docs.map(function (doc) {
        const id = doc.id;
        const data = doc.data();
        return {
            id, ...data,
        }
    });
    return result;
});

exports.getTopArtists = functions.https.onCall(async (data, context) => {
    const snap = await firestore.collection('artists').orderBy('follow_count', 'desc').limit(5).get();
    const result = snap.docs.map(function (doc) {
        const id = doc.id;
        const data = doc.data();
        return {
            id, ...data,
        }
    });
    return result;
});

exports.getArtistsFromSong = functions.https.onCall(async (data, context) => {
    const songSnap = await firestore.collection('songs').doc(data.id).get();
    const artistRefs = songSnap.data().artists;

    const result = await Promise.all(artistRefs.map(async function (ref) {
        const snap = await ref.get();
        return snap.data();
    }));

    return result;
});

exports.getCollection = functions.https.onCall(async (data, context) => {
    const collectionSnap = await firestore.collection('collections').doc(data.id).get();
    return snap.data();
});