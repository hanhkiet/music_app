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
    const id = data.id;
    if (id == null) return {};

    const snap = await firestore.collection('songs').doc(id).get();
    const snapData = snap.data();

    return { id, ...snapData };
});

exports.getArtist = functions.https.onCall(async (data, context) => {
    const id = data.id;
    if (id == null) return {};

    const snap = await firestore.collection('artists').doc(id).get();
    const snapData = snap.data();

    return { id, ...snapData };
});

exports.getTrendingSongs = functions.https.onCall(async (data, context) => {
    const snap = await firestore.collection('songs').orderBy('play_count', 'desc').limit(5).get();

    const result = snap.docs.map(function (doc) {
        const id = doc.id;
        const snapData = snap.data();

        return { id, ...snapData };
    });

    return result;
});

exports.getTopArtists = functions.https.onCall(async (data, context) => {
    const snap = await firestore.collection('artists').orderBy('follow_count', 'desc').limit(5).get();

    const result = snap.docs.map(function (doc) {
        const id = doc.id;
        const snapData = snap.data();

        return { id, ...snapData };
    });

    return result;
});

exports.getArtistsFromSong = functions.https.onCall(async (data, context) => {
    const id = data.id;
    if (id == null) return {};

    const songSnap = await firestore.collection('songs').doc(id).get();
    const artistRefs = songSnap.data().artists;

    const result = await Promise.all(artistRefs.map(async function (ref) {
        const snap = await firestore.collection('artists').doc(ref).get();

        const snapId = snap.id;
        const snapData = snap.data();

        return { id: snapId, ...snapData };
    }));

    return result;
});

exports.getTopCollections = functions.https.onCall(async (data, context) => {
    const snap = await firestore.collection('collections').limit(5).get();

    const result = snap.docs.map(function (doc) {
        const id = doc.id;
        const data = doc.data();
        return { id, ...data };
    });
    return result;
});

exports.getCollectionsFromArtist = functions.https.onCall(async (data, context) => {
    const id = data.artistId;
    if (id == null) return {};

    const type = data.collectionType ?? 'albums';

    const artistSnap = await firestore.collection('artists').doc(id).get();
    const collectionRefs = type == 'albums' ? artistSnap.data().albums : artistSnap.data().playlists;

    const result = await Promise.all(collectionRefs.map(async function (ref) {

        const snap = await firestore.collection('collections').doc(ref).get();
        const snapId = snap.id;
        const snapData = snap.data();

        return { id: snapId, ...snapData };
    }));

    return result;
});

exports.getSongsFromCollection = functions.https.onCall(async (data, context) => {
    const id = data.id;
    if (id == null) return {};

    const collectionSnap = await firestore.collection('collections').doc(id).get();
    const songRefs = collectionSnap.data().songs;

    const result = await Promise.all(songRefs.map(async function (ref) {

        const snap = await firestore.collection('songs').doc(ref).get();
        const snapId = snap.id;
        const snapData = snap.data();

        return { id: snapId, ...snapData };
    }));

    return result;
});