// Day 5 (Set 1)

// Select database
db = db.getSiblingDB("RetailDB");

/// CREATING COLLECTIONS WITH SCHEMA VALIDATION
// Schema Creation
db.createCollection("productReviews", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["productSku", "customerId", "rating", "reviewText", "reviewDate", "verifiedPurchase"],
            properties: {
                productSku: {
                    bsonType: "string",
                    minLength: 1
                },
                customerId: {
                    bsonType: "string",
                    minLength: 1
                },
                rating: {
                    bsonType: "int",
                    minimum: 1,
                    maximum: 5
                },
                reviewText: {
                    bsonType: "string",
                    minLength: 1
                },
                reviewDate: {
                    bsonType: "date"
                },
                vrifiedPurchase: {
                    bsonType: "bool"
                },
                helpfulVotes: {
                    bsonType: "int",
                    minimum: 0
                },
                tags: {
                    bsonType: "array",
                    items: {
                        bsonType: "string"
                    }
                }
            }
        }
    },
    validationLevel: "strict",
    validationAction: "error"
});


/// INSERTING MANY DATA
// Inserting Data
db.productReviews.insertMany([
    {
        productSku: "SKU-1001",
        customerId: "CUST-001",
        rating: NumberInt(5),
        reviewText: "Excellent wireless mouse. Smooth tracking and comfortable grip.",
        reviewDate: ISODate("2026-10-01T10:30:00Z"),
        verifiedPurchase: true,
        helpfulVotes: NumberInt(12),
        tags: ["electronics", "wireless", "recommended"]
    },
    {
        productSku: "SKU-1001",
        customerId: "CUST-002",
        rating: NumberInt(4),
        reviewText: "Good mouse, but the scroll wheel could be quieter.",
        reviewDate: ISODate("2026-10-03T12:00:00Z"),
        verifiedPurchase: true,
        helpfulVotes: NumberInt(5),
        tags: ["electronics"]
    },
    {
        productSku: "SKU-1002",
        customerId: "CUST-003",
        rating: NumberInt(5),
        reviewText: "Keyboard feels sturdy and typing is comfortable.",
        reviewDate: ISODate("2026-10-04T08:15:00Z"),
        verifiedPurchase: true,
        helpfulVotes: NumberInt(8),
        tags: ["computers", "keyboard"]
    },
    {
        productSku: "SKU-1002",
        customerId: "CUST-004",
        rating: NumberInt(3),
        reviewText: "Works as expected, although the keys are a little noisy.",
        reviewDate: ISODate("2026-10-05T14:45:00Z"),
        verifiedPurchase: false,
        helpfulVotes: NumberInt(2),
        tags: ["computers"]
    },
    {
        productSku: "SKU-1003",
        customerId: "CUST-005",
        rating: NumberInt(5),
        reviewText: "Fresh rice with good quality and packaging.",
        reviewDate: ISODate("2026-10-06T09:20:00Z"),
        verifiedPurchase: true,
        helpfulVotes: NumberInt(10),
        tags: ["groceries", "quality"]
    },
    {
        productSku: "SKU-1004",
        customerId: "CUST-006",
        rating: NumberInt(4),
        reviewText: "Useful notebook pack for everyday office work.",
        reviewDate: ISODate("2026-10-07T11:10:00Z"),
        verifiedPurchase: true,
        helpfulVotes: NumberInt(3),
        tags: ["stationery"]
    },
    {
        productSku: "SKU-1005",
        customerId: "CUST-007",
        rating: NumberInt(2),
        reviewText: "Chair is comfortable, but assembly instructions were unclear.",
        reviewDate: ISODate("2026-10-08T16:30:00Z"),
        verifiedPurchase: true,
        helpfulVotes: NumberInt(1),
        tags: ["furniture", "assembly"]
    },
    {
        productSku: "SKU-1006",
        customerId: "CUST-008",
        rating: NumberInt(5),
        reviewText: "Air fryer is easy to use and cooks evenly.",
        reviewDate: ISODate("2026-10-09T07:50:00Z"),
        verifiedPurchase: true,
        helpfulVotes: NumberInt(15),
        tags: ["appliances", "kitchen"]
    },
    {
        productSku: "SKU-1007",
        customerId: "CUST-009",
        rating: NumberInt(4),
        reviewText: "Nice desk lamp with good brightness.",
        reviewDate: ISODate("2026-10-10T18:05:00Z"),
        verifiedPurchase: false,
        helpfulVotes: NumberInt(4),
        tags: ["lighting"]
    },
    {
        productSku: "SKU-1008",
        customerId: "CUST-010",
        rating: NumberInt(5),
        reviewText: "Great football for casual practice.",
        reviewDate: ISODate("2026-10-11T13:25:00Z"),
        verifiedPurchase: true,
        helpfulVotes: NumberInt(6),
        tags: ["sports", "outdoor"]
    }
]);

/// FIND OPERATIONS
// Retrieve all reviews
db.productReviews.find();

// Retrieve five-star verified reviews
db.productReviews.find({
    rating: NumberInt(5),
    verifiedPurchase: true
});


/// UPDATE ONE REVIEW
// Update
db.productReviews.updateOne(
    {
        productSku: "SKU-1001",
        customerId: "CUST-002"
    },
    {
        $set: {
            reviewText: "Good wireless mouse with reliable tracking. The scroll wheel could be quieter."
        },
        $inc: {
            helpfulVotes: NumberInt(1)
        }
    }
);

// Verify updated document
db.productReviews.findOne({
    productSku: "SKU-1001",
    customerId: "CUST-002"
});


/// DELETE ONE REVIEW
// Delete
db.productReviews.deleteOne({
    productSku: "SKU-1008",
    customerId: "CUST-010"
});

// Verify deletion
db.productReviews.countDocuments();