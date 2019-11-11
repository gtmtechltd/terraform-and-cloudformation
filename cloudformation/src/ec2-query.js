var AWS           = require('aws-sdk');
AWS.config.region = 'us-west-1';

exports.handler = function(event, context) {
    console.log("\n\nLoading handler\n\n");
    var ec2 = new AWS.EC2();
    ec2.describeInstances( function(err, data) {
        console.log("\nIn describe instances:\n");
        if (err) console.log(err, err.stack); // an error occurred
        else     console.log("\n\n" + data + "\n\n"); // successful response
        context.done(null, 'Function Finished!');  
    });
};
