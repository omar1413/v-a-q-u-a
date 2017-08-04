var path = window.id || 0;
path = '../../' + path;
window.path = path
console.log(path);
if(path == '/vaqua/0')
    alert("there is no data available");
$.getJSON(path, function(data) {
    // var obj  = json.parse(data);
    var table = document.getElementById('data');
    var tableData = '<table border="1" class="table">';
    for (var i in data) {
        var key = i;
        // console.log(i);
        var val = data[i];
        if (i == 0) {
            tableData += '<thead><tr>';
        } else {
          if(i==1)
          {
            tableData += '<tbody><tr>';
        }
        else{
            tableData += '<tr>';
        }
      }
        // console.log(key);

        for (var j in val) {
            var sub_key = j;
            var sub_val = val[j];

            if (i == 0) {
                tableData += '<th>' + sub_key + '</th>';

            } else {
                tableData += '<td>' + sub_val + '</td>';
            }
            // console.log(sub_key);

        }
        if(i==0)
        {
              tableData += '</tr></thead>';
        }else{
            tableData += '</tr>';
      }
    }
    tableData += '</tbody></table>';
    table.innerHTML = tableData;
});
