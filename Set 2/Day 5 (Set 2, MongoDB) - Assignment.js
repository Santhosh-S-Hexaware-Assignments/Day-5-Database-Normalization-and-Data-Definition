// Day 5 (Set 2)

// Select Database
db = db.getSiblingDB("BankDB");


/// CREATING CAPPED COLLECTION

// Drop Existing Collection (if any)
db.customerActivity.drop();

// Create Capped Collection
db.createCollection("customerActivity", {
    capped: true,
    size: 1048576,
    max: 1000
});


/// INSERTING MANY DATA

// Inserting 20 Customer Activity Documents
db.customerActivity.insertMany([

    {
        customerId: "CUST-001",
        activityType: "LOGIN",
        eventTime: ISODate("2026-07-01T08:30:00Z"),
        channel: "Mobile",
        ipAddress: "192.168.1.10",
        details: {
            device: "Android",
            status: "Success"
        }
    },
    {
        customerId: "CUST-001",
        activityType: "LOGIN",
        eventTime: ISODate("2026-07-04T09:15:00Z"),
        channel: "Web",
        ipAddress: "192.168.1.11",
        details: {
            device: "MacBook",
            status: "Success"
        }
    },
    {
        customerId: "CUST-001",
        activityType: "TRANSFER",
        eventTime: ISODate("2026-07-10T11:20:00Z"),
        channel: "Mobile",
        ipAddress: "192.168.1.10",
        details: {
            amount: 5000,
            recipient: "CUST-002",
            status: "Completed"
        }
    },
    {
        customerId: "CUST-001",
        activityType: "LOGIN",
        eventTime: ISODate("2026-08-10T07:45:00Z"),
        channel: "Mobile",
        ipAddress: "192.168.1.12",
        details: {
            device: "Android",
            status: "Success"
        }
    },
    {
        customerId: "CUST-001",
        activityType: "LOGOUT",
        eventTime: ISODate("2026-08-10T08:30:00Z"),
        channel: "Mobile",
        ipAddress: "192.168.1.12",
        details: {
            status: "Success"
        }
    },
    {
        customerId: "CUST-001",
        activityType: "LOGIN",
        eventTime: ISODate("2026-09-15T10:00:00Z"),
        channel: "Web",
        ipAddress: "192.168.1.13",
        details: {
            device: "MacBook",
            status: "Success"
        }
    },
    {
        customerId: "CUST-001",
        activityType: "LOGIN",
        eventTime: ISODate("2026-10-10T12:30:00Z"),
        channel: "Mobile",
        ipAddress: "192.168.1.14",
        details: {
            device: "Android",
            status: "Success"
        }
    },
    {
        customerId: "CUST-002",
        activityType: "LOGIN",
        eventTime: ISODate("2026-07-02T08:00:00Z"),
        channel: "Web",
        ipAddress: "192.168.2.10",
        details: {
            device: "Windows",
            status: "Success"
        }
    },
    {
        customerId: "CUST-002",
        activityType: "TRANSFER",
        eventTime: ISODate("2026-07-05T13:30:00Z"),
        channel: "Mobile",
        ipAddress: "192.168.2.11",
        details: {
            amount: 12000,
            recipient: "CUST-003",
            status: "Completed"
        }
    },
    {
        customerId: "CUST-002",
        activityType: "LOGIN",
        eventTime: ISODate("2026-08-12T09:20:00Z"),
        channel: "Mobile",
        ipAddress: "192.168.2.12",
        details: {
            device: "Android",
            status: "Success"
        }
    },
    {
        customerId: "CUST-002",
        activityType: "LOGOUT",
        eventTime: ISODate("2026-08-12T10:00:00Z"),
        channel: "Mobile",
        ipAddress: "192.168.2.12",
        details: {
            status: "Success"
        }
    },
    {
        customerId: "CUST-002",
        activityType: "LOGIN",
        eventTime: ISODate("2026-09-20T07:50:00Z"),
        channel: "Web",
        ipAddress: "192.168.2.13",
        details: {
            device: "Windows",
            status: "Success"
        }
    },
    {
        customerId: "CUST-003",
        activityType: "LOGIN",
        eventTime: ISODate("2026-07-15T11:10:00Z"),
        channel: "Mobile",
        ipAddress: "192.168.3.10",
        details: {
            device: "Android",
            status: "Success"
        }
    },
    {
        customerId: "CUST-003",
        activityType: "TRANSFER",
        eventTime: ISODate("2026-08-01T14:30:00Z"),
        channel: "Web",
        ipAddress: "192.168.3.11",
        details: {
            amount: 8000,
            recipient: "CUST-001",
            status: "Completed"
        }
    },
    {
        customerId: "CUST-003",
        activityType: "LOGIN",
        eventTime: ISODate("2026-09-05T08:45:00Z"),
        channel: "Mobile",
        ipAddress: "192.168.3.12",
        details: {
            device: "Android",
            status: "Success"
        }
    },
    {
        customerId: "CUST-003",
        activityType: "LOGOUT",
        eventTime: ISODate("2026-09-05T09:30:00Z"),
        channel: "Mobile",
        ipAddress: "192.168.3.12",
        details: {
            status: "Success"
        }
    },
    {
        customerId: "CUST-004",
        activityType: "LOGIN",
        eventTime: ISODate("2026-07-20T10:15:00Z"),
        channel: "Web",
        ipAddress: "192.168.4.10",
        details: {
            device: "Windows",
            status: "Success"
        }
    },
    {
        customerId: "CUST-004",
        activityType: "TRANSFER",
        eventTime: ISODate("2026-08-18T16:00:00Z"),
        channel: "Mobile",
        ipAddress: "192.168.4.11",
        details: {
            amount: 15000,
            recipient: "CUST-002",
            status: "Completed"
        }
    },
    {
        customerId: "CUST-004",
        activityType: "LOGIN",
        eventTime: ISODate("2026-09-22T09:00:00Z"),
        channel: "Mobile",
        ipAddress: "192.168.4.12",
        details: {
            device: "Android",
            status: "Success"
        }
    },
    {
        customerId: "CUST-004",
        activityType: "LOGOUT",
        eventTime: ISODate("2026-09-22T09:45:00Z"),
        channel: "Mobile",
        ipAddress: "192.168.4.12",
        details: {
            status: "Success"
        }
    },
    {
        customerId: "CUST-004",
        activityType: "LOGIN",
        eventTime: ISODate("2026-10-15T12:00:00Z"),
        channel: "Web",
        ipAddress: "192.168.4.13",
        details: {
            device: "Windows",
            status: "Success"
        }
    }

]);


/// FIND OPERATIONS

// Retrieve All Customer Activity
db.customerActivity.find();


// Retrieve All Login Events
db.customerActivity.find({
    activityType: "LOGIN"
});


// Retrieve Activity of a Specific Customer
db.customerActivity.find({
    customerId: "CUST-001"
});


/// RETRIEVE LAST FIVE LOGIN EVENTS

// Last Five Login Events of CUST-001
db.customerActivity.find({
    customerId: "CUST-001",
    activityType: "LOGIN"
}).sort({
    eventTime: -1
}).limit(5);


// Verify Total Documents
db.customerActivity.countDocuments();


// Verify Capped Collection Details
db.getCollectionInfos({
    name: "customerActivity"
});