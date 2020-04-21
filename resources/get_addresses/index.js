console.log('function starts');

const AWS = require('aws-sdk');
// AWS.config.update({endpoint: "http://10.0.2.2:4569"});
const docClient = new AWS.DynamoDB.DocumentClient({endpoint: "http://10.0.2.2:4569", region: 'us-east-1'});

exports.handler = function(event, context, callback) {
    console.log('processing the following event`: %j', event);

    let scanningParameters = {
        TableName: 'Addresses',
        Limit: 100
    };

    //In dynamoDB scan looks through your entire table and fetches all data
    docClient.scan(scanningParameters, function (err, data) {
        if (err) {
            callback(err, null);
        } else {
            console.log(JSON.stringify(data));
            const response = {
                "statusCode": 200,
                "headers": {
                    "Content-Type": "application/json"
                },
                "body": JSON.stringify(data)
            };
            callback(null, response);
        }
    })
};
