;(function () {
    //Container object to our values and have some helper methods
    var Parser = function () {
        this.data = data;
        this.fields = [];
    };

    //initialize helper methods here
    Parser.prototype = {
        getFieldData : function (field) {
            return this[field];
        }

        //TODO:other methods to help parse data
    }


    //initiallize an ibject
parser = new Parser();

    //get data from json file
    var gJsonData = function(path) {
        var promise = new Promise(function(resolve, reject){
            $.getJSON(path,function (data) {
                parser.data = data;
                resolve(parser);
            })
        });
        return promise;
    };

    //extract fields from data
    var iniData = function(parser) {
        var promise = new Promise(function(resolve, reject) {
            var data = parser.data;
            for (var i in data) {
                var key = i;
                var val = data[i];

                for (var j in val) {
                    var sub_key = j;
                    var sub_val = val[j];
                    //check if the filde is attached already or not
                    if (parser[sub_key] === undefined)

                        parser[sub_key] = [];
                    else
                        parser[sub_key].push(sub_val);
                    //to add field only one time
                    if (i == 0)
                        parser.fields.push(sub_key);
                }

            }
            resolve(parser);
        });

        return promise;
    };


    //do your processing here
    var executionEnvironment = function(parser) {
        var promise = new Promise(function(resolve, reject) {
            console.log(parser.getFieldData(parser.fields[0]));
            resolve(parser);
        });
        return promise;
    };


    gJsonData(path)
        .then(iniData)
        .then(executionEnvironment);
}());