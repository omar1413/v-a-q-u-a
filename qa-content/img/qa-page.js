$('#mmd').ready(function () {
    $('#mmd').submit(function(e) {
        e.preventDefault(); // don't submit multiple times
        this.submit(); // use the native submit method of the form element
        var checkValue=null;
        // var inputElements=document.getElementById('2');

        // for(var i=0;)
        var intes=[];
            for(var i=1;i<17;i++){
                var inputElements=document.getElementById(i+'');
                console.log(inputElements);
                // alert("ASd")
                // alert("asdasdlkara")
                // console.log(inputElements.checked);
                if(inputElements.checked)
                    intes.push(1);
                else {
                    intes.push(0);
                }
                console.log(intes[i-1]);
            }


            // alert(intes[1]);
            // alert(intes[10]);
            $.ajax({
                type:'POST',
                url:'./test.php',
                data:{
                    health:intes[0],
                    health_eating:intes[1],
                    medicine :intes[2],
                    exercise:intes[3],
                    history:intes[4],
                    World_history:intes[5],
                    World_War:intes[6],
                    Philosophy:intes[7],
                    Technology :intes[8],
                    Science :intes[9],
                    Physics :intes[10],
                    Computer_science:intes[11],
                    Design :intes[12],
                    Photography :intes[13],
                    Fine_art:intes[14],
                    Web_design:intes[15],
                },
                success: function (){
                    // content.html(response);
                    console.log("Asdadaswewfs");
                }
            });
            // alert(data);
            // alert('asf+1')

        // if(!regForm)
        // {
        // 	alert("i am defned")
        // }
        // else{
        // 	alert('asdasd')
        // 	regForm.innerHTML +="<input type='checkbox' value='' name='group2' style='margin-left:140px;vertical-align:sub' />History";
        // }
    });
})

window.onload=function(){
  var inter={
        1:'Technology',
        2:'Science',
        3:'History',
        4:'Health',
        5:'Photography',
        6:'Exercise',
        7:'Physics',
        8:'Design',
        9:'Computer science',
        10:'Traveling',
        11:'Economics',
        12:'Fine Arts',
        13:'Banking & Finance',
        14:'Medicine',
        15:'Psychology',
    }

    var photo={
      1:'./qa-content/img/technology.jpg',
      2:'./qa-content/img/science.jpg',
      3:'./qa-content/img/history.jpg',
      4:'./qa-content/img/health.jpg',
      5:'./qa-content/img/photography.jpg',
      6:'./qa-content/img/exercise.jpg',
      7:'./qa-content/img/physics.jpg',
      8:'./qa-content/img/design.jpg',
      9:'./qa-content/img/computer_science.jpg',
      10:'./qa-content/img/traveling.jpg',
      11:'./qa-content/img/economics.jpg',
      12:'./qa-content/img/fine_arts.jpg',
      13:'./qa-content/img/banking.jpg',
      14:'./qa-content/img/medicine.jpg',
      15:'./qa-content/img/psychology.jpg',
    }

    // // console.log(inter[1]);
    var x=document.getElementById('sModel');
    var regFrom=document.getElementById('mmd');

// <button id='myBtn'>Open Modal</button>
    var openModelBtn = document.createElement("a");
    openModelBtn.setAttribute("id", "myBtn");
    openModelBtn.setAttribute("class", "continueBtn");
    var openModelBtnText = document.createTextNode('continue');
    openModelBtn.appendChild(openModelBtnText)
    regFrom.appendChild(openModelBtn);
    var openModelBtnId=document.getElementById('myBtn');
    // var btnDiv = document.createElement("div");
    // btnDiv.setAttribute("id", "myModel");
    // btnDiv.setAttribute("class", "model");
    // var btnDiv2 = document.createElement("div");
    // btnDiv2.setAttribute("id", "model-content");
    // btnDiv.appendChild(btnDiv2);
    // x.appendChild(btn1);
    // x.appendChild(btnDiv);

// Get the modal

var modal = document.getElementById('myModal');

// Get the button that opens the modal
var btn = document.getElementById("myBtn");
var regbtn = document.getElementById("okbtn");
var regbtn1 = document.getElementById("regbtn");

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];

// When the user clicks on the button, open the modal
btn.onclick = function() {
    $(modal).slideDown();
}
regbtn.onclick=function(){
  modal.style.display = "none";
  regbtn1.style.display="block";
  openModelBtnId.style.display="none"

}

// When the user clicks on <span> (x), close the modal
span.onclick = function() {
    modal.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }

    if(numberOfCheckboxesSelected() < 4){
      nodes.setAttribute("value", " Choose at least 4 interests ");
      nodes.setAttribute("class", "button2");
      // nodes.setAttribute("class", "button2");
    console.log(numberOfCheckboxesSelected());
  }

    else if(numberOfCheckboxesSelected() >= 4){
      nodes.setAttribute("value", " Submit ");
      nodes.setAttribute("class", "button");
      // nodes.setAttribute("class", "button2");
    console.log(numberOfCheckboxesSelected());
  }
}


var dp4 = document.createElement("div");
var sp1 = document.createElement("span");

       dp4.setAttribute("class","dialog_wrapper large_dialog_wrapper follow_interests");
       dp4.setAttribute("id","id01");

       sp1.setAttribute("class","close");  /*<- problem here*/

             dp4.appendChild(sp1);




var dp5 = document.createElement("div");
var dp6 = document.createElement("div");
var tp = document.createTextNode("Choose your interests ...");
var dp7 = document.createElement("div");
       dp5.setAttribute("id", "world");
       dp6.setAttribute("class", "title");
       dp7.setAttribute("style", "line-height: 1.5; margin-bottom: 18px;");


               dp4.appendChild(dp5);
               dp5.appendChild(dp6);
               dp6.appendChild(tp);
               dp5.appendChild(dp7);


var dp8 = document.createElement("div");
var dp9 = document.createElement("div");
var dp10 = document.createElement("div");
var dp11 = document.createElement("div");
        dp8.setAttribute("class", "ux_dialog_interests");
        dp10.setAttribute("class","interest_window_wrapper");
        dp10.setAttribute("style","background-color:#fafafa;");
        dp11.setAttribute("class","dynamic_interests row");

             dp5.appendChild(dp8);
             dp8.appendChild(dp9);
             dp9.appendChild(dp10);
             dp10.appendChild(dp11);


  var i;
  for (i = 1; i <16; i++) {
       var div1 = document.createElement("div");
       var div2 = document.createElement("div");

       var div3 = document.createElement("div");
       var div4 = document.createElement("div");
       var div5 = document.createElement("div");
       var div6 = document.createElement("div");
               div2.setAttribute("class", "interest_photo");
               div3.setAttribute("class","photo");
               div5.setAttribute("class","TopicPhoto");
               // div.setAttribute("style", "");

               var node1 = document.createElement("a");
               node1.setAttribute("href", '#');
               var node2 = document.createElement("img");
               node2.setAttribute("src", photo[i]);
               node2.setAttribute("alt", inter[i]);
               node2.setAttribute("style", "width:115px; height:90px;");

                 div1.appendChild(div2);
                 div2.appendChild(div3);
                 div3.appendChild(div4);
                 div4.appendChild(div5);
                 div5.appendChild(div6);
                 div6.appendChild(node1);
                 node1.appendChild(node2);

               // w.appendChild(div1);
               // var textnode = document.createTextNode(inter[i]);

        var div7 = document.createElement("div");
        var span1 = document.createElement("span");
                 div7.setAttribute("class", "info_wrapper");
                 span1.setAttribute("class", "info_background");

                 var label1 = document.createElement("label");
                           label1.setAttribute("class", "label");


                            var nodec = document.createElement("input");
                            nodec.setAttribute("type", "checkbox");
                            nodec.setAttribute("id", 'id'+i);
                            nodec.setAttribute("name", "seatdata");
                            nodec.setAttribute("value", "shero");


                            var span2 = document.createElement("span");

                                        div2.appendChild(div7);
                                        div7.appendChild(span1);
                                        span1.appendChild(label1);
                                        label1.appendChild(nodec);
                                        label1.appendChild(span2);


               var div8 = document.createElement("div");
                       div8.setAttribute("class", "info");

                       var span3 = document.createElement("span");


                                var span4 = document.createElement("span");
                                         span4.setAttribute("class", "TopicNameSpan TopicName");

                                         var t = document.createTextNode(inter[i]);

                                                span1.appendChild(div8);
                                                div8.appendChild(span3);
                                                span3.appendChild(span4);
                                                span4.appendChild(t);



                                        dp11.appendChild(div1);

}


   var nodes = document.createElement("input");
            nodes.setAttribute("id", "enable-on-four");
            nodes.setAttribute("type", "submit");
            // nodes.setAttribute("class", "button");
            // nodes.setAttribute("value", " Check at least 4 ");
            nodes.setAttribute("disabled", true);
            // nodes.setAttribute('onclick', 'send_query(document.getElementsByTagName('seatdata'));');
            // var y=document.getElementsByTagName('seatdata');
            // console.log(y);

            
            dp5.appendChild(nodes);

    x.appendChild(dp4);
    // document.getElementById("myList").appendChild(node);



  //   function send_query(check) {
  //     console.log(check);
  //     console.log(check[1].value);
  //     var values = [];
  //     for (var i = 0; i < check.length; i++) {
  //         if (check[i].checked == true) {
  //             values.push(check[i].value);
  //         }
  //     }
  //
  //     return values.join();
  // }
  //
  // onload = function () {
  //   var z=document.getElementsByTagName('seatdata');
  //   console.log(z);
  //     var s=send_query(document.getElementsByName('seatdata'));
  //       alert(s);
  //
  // };


    function numberOfCheckboxesSelected() {
      var c=document.querySelectorAll('input[type=checkbox][name="seatdata"]:checked').length;
    	return c;

    }

    function onChange() {

    	document.getElementById('enable-on-four').disabled = numberOfCheckboxesSelected() < 4;

    }

    document.getElementById('world').addEventListener('change', onChange, false);


}
/*
 Question2Answer by Gideon Greenspan and contributors

 http://www.question2answer.org/


 File: qa-content/qa-page.js
 Version: See define()s at top of qa-include/qa-base.php
 Description: Common Javascript including voting, notices and favorites


 This program is free software; you can redistribute it and/or
 modify it under the terms of the GNU General Public License
 as published by the Free Software Foundation; either version 2
 of the License, or (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 More about this license: http://www.question2answer.org/license.php
 */

function qa_reveal(elem, type, callback)
{
    if (elem)
        $(elem).slideDown(400, callback);
}

function qa_conceal(elem, type, callback)
{
    if (elem)
        $(elem).slideUp(400);
}

function qa_set_inner_html(elem, type, html)
{
    if (elem)
        elem.innerHTML=html;
}

function qa_set_outer_html(elem, type, html)
{
    if (elem) {
        var e=document.createElement('div');
        e.innerHTML=html;
        elem.parentNode.replaceChild(e.firstChild, elem);
    }
}

function qa_show_waiting_after(elem, inside)
{
    if (elem && !elem.qa_waiting_shown) {
        var w=document.getElementById('qa-waiting-template');

        if (w) {
            var c=w.cloneNode(true);
            c.id=null;

            if (inside)
                elem.insertBefore(c, null);
            else
                elem.parentNode.insertBefore(c, elem.nextSibling);

            elem.qa_waiting_shown=c;
        }
    }
}

function qa_hide_waiting(elem)
{
    var c=elem.qa_waiting_shown;

    if (c) {
        c.parentNode.removeChild(c);
        elem.qa_waiting_shown=null;
    }
}

function qa_vote_click(elem)
{
    var ens=elem.name.split('_');
    var postid=ens[1];
    var vote=parseInt(ens[2]);
    var code=elem.form.elements.code.value;
    var anchor=ens[3];

    qa_ajax_post('vote', {postid:postid, vote:vote, code:code},
        function(lines) {
            if (lines[0]=='1') {
                qa_set_inner_html(document.getElementById('voting_'+postid), 'voting', lines.slice(1).join("\n"));

            } else if (lines[0]=='0') {
                var mess=document.getElementById('errorbox');

                if (!mess) {
                    var mess=document.createElement('div');
                    mess.id='errorbox';
                    mess.className='qa-error';
                    mess.innerHTML=lines[1];
                    mess.style.display='none';
                }

                var postelem=document.getElementById(anchor);
                var e=postelem.parentNode.insertBefore(mess, postelem);
                qa_reveal(e);

            } else
                qa_ajax_error();
        }
    );

    return false;
}

function qa_notice_click(elem)
{
    var ens=elem.name.split('_');
    var code=elem.form.elements.code.value;

    qa_ajax_post('notice', {noticeid:ens[1], code:code},
        function(lines) {
            if (lines[0]=='1')
                qa_conceal(document.getElementById('notice_'+ens[1]), 'notice');
            else if (lines[0]=='0')
                alert(lines[1]);
            else
                qa_ajax_error();
        }
    );

    return false;
}

function qa_favorite_click(elem)
{
    var ens=elem.name.split('_');
    var code=elem.form.elements.code.value;

    qa_ajax_post('favorite', {entitytype:ens[1], entityid:ens[2], favorite:parseInt(ens[3]), code:code},
        function (lines) {
            if (lines[0]=='1')
                qa_set_inner_html(document.getElementById('favoriting'), 'favoriting', lines.slice(1).join("\n"));
            else if (lines[0]=='0') {
                alert(lines[1]);
                qa_hide_waiting(elem);
            } else
                qa_ajax_error();
        }
    );

    qa_show_waiting_after(elem, false);

    return false;
}

function qa_ajax_post(operation, params, callback)
{
    jQuery.extend(params, {qa:'ajax', qa_operation:operation, qa_root:qa_root, qa_request:qa_request});

    jQuery.post(qa_root, params, function(response) {
        var header='QA_AJAX_RESPONSE';
        var headerpos=response.indexOf(header);

        if (headerpos>=0)
            callback(response.substr(headerpos+header.length).replace(/^\s+/, '').split("\n"));
        else
            callback([]);

    }, 'text').fail(function(jqXHR) { if (jqXHR.readyState>0) callback([]) });
}

function qa_ajax_error()
{
    alert('Unexpected response from server - please try again or switch off Javascript.');
}
