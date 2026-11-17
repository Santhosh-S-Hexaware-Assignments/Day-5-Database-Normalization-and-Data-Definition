// Day 5 (Set 3)

// Select Database
db = db.getSiblingDB("HospitalDB");


/// CREATING COLLECTIONS WITH SCHEMA VALIDATION

// Schema Creation
db.createCollection("clinicalNotes", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["patientId", "doctorId", "noteDate", "diagnosis", "noteType"],
            properties: {
                patientId: {
                    bsonType: "string",
                    minLength: 1
                },
                doctorId: {
                    bsonType: "string",
                    minLength: 1
                },
                noteDate: {
                    bsonType: "date"
                },
                diagnosis: {
                    bsonType: "string",
                    minLength: 1
                },
                noteType: {
                    bsonType: "string",
                    enum: ["Consultation", "FollowUp"]
                },
                symptoms: {
                    bsonType: "string"
                },
                prescription: {
                    bsonType: "string"
                },
                observations: {
                    bsonType: "string"
                },
                vitals: {
                    bsonType: "object",
                    properties: {
                        bloodPressure: {
                            bsonType: "string"
                        },
                        temperature: {
                            bsonType: "double"
                        },
                        heartRate: {
                            bsonType: "int"
                        }
                    }
                },
                recommendations: {
                    bsonType: "array",
                    items: {
                        bsonType: "string"
                    }
                },
                followUpDate: {
                    bsonType: "date"
                }
            }
        }
    },
    validationLevel: "strict",
    validationAction: "error"
});


/// INSERTING MANY DATA

// Inserting Clinical Notes of Different Document Structures
db.clinicalNotes.insertMany([

    // Consultation Note - Structure 1
    {
        patientId: "PAT-001",
        doctorId: "DOC-001",
        noteDate: ISODate("2026-09-05T10:00:00Z"),
        noteType: "Consultation",
        diagnosis: "Hypertension",
        symptoms: "Frequent headaches and elevated blood pressure.",
        prescription: "Amlodipine 5mg daily",
        observations: "Blood pressure is higher than the normal range."
    },
    {
        patientId: "PAT-002",
        doctorId: "DOC-003",
        noteDate: ISODate("2026-09-12T11:30:00Z"),
        noteType: "Consultation",
        diagnosis: "Migraine",
        symptoms: "Severe recurring headaches with sensitivity to light.",
        prescription: "Paracetamol 500mg as needed",
        observations: "Patient reports recurring migraine episodes."
    },
    {
        patientId: "PAT-003",
        doctorId: "DOC-005",
        noteDate: ISODate("2026-09-20T09:15:00Z"),
        noteType: "Consultation",
        diagnosis: "Knee Pain",
        symptoms: "Pain and stiffness in the right knee.",
        prescription: "Pain medication and physiotherapy",
        observations: "Mild inflammation observed around the knee joint."
    },
    {
        patientId: "PAT-004",
        doctorId: "DOC-007",
        noteDate: ISODate("2026-10-02T08:45:00Z"),
        noteType: "Consultation",
        diagnosis: "Common Cold",
        symptoms: "Runny nose, cough and mild fever.",
        prescription: "Cetirizine 10mg daily",
        observations: "No major complications observed."
    },
    {
        patientId: "PAT-005",
        doctorId: "DOC-001",
        noteDate: ISODate("2026-10-05T12:00:00Z"),
        noteType: "Consultation",
        diagnosis: "Coronary Artery Disease",
        symptoms: "Chest discomfort and shortness of breath.",
        prescription: "Aspirin 75mg daily",
        observations: "Further cardiac evaluation recommended."
    },

    // Follow-up Note - Structure 2
    {
        patientId: "PAT-001",
        doctorId: "DOC-001",
        noteDate: ISODate("2026-10-05T10:30:00Z"),
        noteType: "FollowUp",
        diagnosis: "Hypertension",
        observations: "Blood pressure has improved after medication.",
        vitals: {
            bloodPressure: "130/85",
            temperature: 36.8,
            heartRate: NumberInt(78)
        },
        recommendations: [
            "Continue prescribed medication",
            "Reduce salt intake",
            "Exercise regularly"
        ],
        followUpDate: ISODate("2026-11-05T00:00:00Z")
    },
    {
        patientId: "PAT-006",
        doctorId: "DOC-009",
        noteDate: ISODate("2026-10-08T14:00:00Z"),
        noteType: "Consultation",
        diagnosis: "Skin Allergy",
        symptoms: "Redness and itching on the arms.",
        prescription: "Antihistamine cream",
        observations: "Allergic skin reaction observed."
    },
    {
        patientId: "PAT-007",
        doctorId: "DOC-008",
        noteDate: ISODate("2026-10-12T09:30:00Z"),
        noteType: "FollowUp",
        diagnosis: "Viral Fever",
        observations: "Fever has reduced and patient is recovering.",
        vitals: {
            bloodPressure: "115/75",
            temperature: 37.0,
            heartRate: NumberInt(82)
        },
        recommendations: [
            "Maintain hydration",
            "Get sufficient rest",
            "Monitor body temperature"
        ],
        followUpDate: ISODate("2026-10-19T00:00:00Z")
    },
    {
        patientId: "PAT-008",
        doctorId: "DOC-002",
        noteDate: ISODate("2026-10-15T11:00:00Z"),
        noteType: "Consultation",
        diagnosis: "Chest Pain",
        symptoms: "Intermittent chest pain and discomfort.",
        prescription: "ECG and further cardiac evaluation",
        observations: "Patient requires additional cardiac investigation."
    },
    {
        patientId: "PAT-009",
        doctorId: "DOC-004",
        noteDate: ISODate("2026-10-20T13:45:00Z"),
        noteType: "FollowUp",
        diagnosis: "Chronic Headache",
        observations: "Headache frequency has decreased.",
        vitals: {
            bloodPressure: "120/80",
            temperature: 36.7,
            heartRate: NumberInt(76)
        },
        recommendations: [
            "Continue monitoring symptoms",
            "Maintain regular sleep schedule",
            "Attend scheduled follow-up"
        ],
        followUpDate: ISODate("2026-11-20T00:00:00Z")
    }

]);


/// FIND OPERATIONS

// Retrieve All Clinical Notes
db.clinicalNotes.find();


// Retrieve Consultation Notes
db.clinicalNotes.find({
    noteType: "Consultation"
});


// Retrieve Follow-up Notes
db.clinicalNotes.find({
    noteType: "FollowUp"
});


/// QUERY BY DIAGNOSIS

// Retrieve Patients Diagnosed with Hypertension
db.clinicalNotes.find({
    diagnosis: "Hypertension"
});


// Retrieve Patients Diagnosed with Common Cold
db.clinicalNotes.find({
    diagnosis: "Common Cold"
});


// Retrieve All Notes Containing the Word 'Pain' in Diagnosis
db.clinicalNotes.find({
    diagnosis: {
        $regex: "Pain",
        $options: "i"
    }
});


/// VERIFY INSERTED DATA

// Total Clinical Notes
db.clinicalNotes.countDocuments();


// Count Consultation Notes
db.clinicalNotes.countDocuments({
    noteType: "Consultation"
});


// Count Follow-up Notes
db.clinicalNotes.countDocuments({
    noteType: "FollowUp"
});