exports.handler = (event, context, callback) => {
    var response = {
        statusCode: 200,
        headers: {
            'Content-Type': 'text/html; charset=utf-8'
        },
        body: JSON.stringify({data: "something"})
    };
    callback(null, response);
};