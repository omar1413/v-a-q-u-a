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
        1:'health',
        2:'healthy eating',
        3:'medicine',
        4:'exercise',
        5:'History',
        6:'World History',
        7:'World War ||',
        8:'Philosophy',
        9:'Technology',
        10:'Science',
        11:'Physics',
        12:'Computer science',
        13:'design',
        14:'Photography',
        15:'Fine Art',
        16:'Wb Design'
    }
    // // console.log(inter[1]);
    var x=document.getElementById('sModel');
    var regFrom=document.getElementById('mmd');

// <button id='myBtn'>Open Modal</button>
    var openModelBtn = document.createElement("a");
    openModelBtn.setAttribute("id", "myBtn");
    openModelBtn.setAttribute("class", "continueBtn");
    openModelBtn.setAttribute("style", "display:inline-block");
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
}
    var bigCon = document.createElement("div");
    bigCon.setAttribute("style", "margin-top:-10px");
    for(var w=1;w<17;w++){

        var con = document.createElement("span");
        con.setAttribute("style", "display: inline-block;width: 24%;text-align: left;margin-top:25px;margin-right: 5px;background: url('./qa-content/img/"+w+".jpg');background-size: cover;background-repeat: no-repeat;height: 75px;text-align: right;");
        // con.setAttribute("style", "");
        var node = document.createElement("input");
        node.setAttribute("type", "checkbox");
        node.setAttribute("style", "    transform: translateX(-105px);min-width: 16px;min-height: 30px;");
        node.setAttribute("id", ''+w);
        node.setAttribute("value", ''+inter[w]);
        var pargraph = document.createElement("p");
        pargraph.setAttribute("style",' transform: translateY(38px);width: 100%;background: #666666;text-align: center;color:#fff');

        var textnode = document.createTextNode(inter[w]);
        // console.log(textnode);

        pargraph.appendChild(textnode);
        con.appendChild(node);
        con.appendChild(pargraph);
        bigCon.appendChild(con);

        if(w%4==0)
        {
            var line=document.createElement('br');
            bigCon.appendChild(line);
        }
        //  document.getElementById("myList").appendChild(node);
    }
    x.appendChild(bigCon);
    // document.getElementById("myList").appendChild(node);

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
