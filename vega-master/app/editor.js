'use strict';

var vaqua = {};

vaqua.q_id = 0;

var VAQUA = 'vaqua';
var VAQUA_LITE = 'vaqua-lite';

var ved = {
    version: '1.2.0',
    data: undefined,
    renderType: 'canvas',
    editor: {
        vaqua: null,
        'vaqua-lite': null
    },
    currentMode: null,
    vgHidden: true  // vaqua editor hidden in vl mode
};

ved.isPathAbsolute = function (path) {
    return /^(?:\/|[a-z]+:\/\/)/.test(path);
};

ved.params = function () {
    var query = location.search.slice(1);
    if (query.slice(-1) === '/') query = query.slice(0, -1);
    return query
        .split('&')
        .map(function (x) {
            return x.split('=');
        })
        .reduce(function (a, b) {
            a[b[0]] = b[1];
            return a;
        }, {});
};

ved.mode = function () {
    var $d3 = ved.$d3,
        sel = $d3.select('.sel_mode').node(),
        vge = $d3.select('.vaqua-editor'),
        ace = $d3.select('.vg-spec .ace_content'),
        idx = sel.selectedIndex,
        newMode = sel.options[idx].value,
        spec;

    if (ved.currentMode === newMode) return;
    ved.currentMode = newMode;

    if (ved.currentMode === VAQUA) {
        ved.editor[VAQUA].setOptions({
            readOnly: false,
            highlightActiveLine: true,
            highlightGutterLine: true
        });

        ace.attr('class', 'ace_content');
    } else if (ved.currentMode === VAQUA_LITE) {
        ved.editor[VAQUA].setOptions({
            readOnly: true,
            highlightActiveLine: false,
            highlightGutterLine: false
        });

        ace.attr('class', 'ace_content disabled');
    } else {
        throw new Error('Unknown mode ' + ved.currentMode);
    }

    vge.attr('class', 'vaqua-editor ' + ved.currentMode);

    ved.editorVisibility();
    ved.getSelect().selectedIndex = 0;
    ved.select('');
};

ved.switchToVaqua = function () {
    var sel = ved.$d3.select('.sel_mode').node(),
        spec = ved.editor[VAQUA].getValue();
    sel.selectedIndex = 0;
    ved.mode();
    ved.select(spec);
};

// Changes visibility of vaqua editor in vl mode
ved.editorVisibility = function () {
    var $d3 = ved.$d3,
        vgs = $d3.select('.vg-spec'),
        vls = $d3.select('.vl-spec'),
        toggle = $d3.select('.click_toggle_vaqua');

    if (ved.vgHidden && ved.currentMode === VAQUA_LITE) {
        vgs.style('display', 'none');
        vls.style('flex', '1 1 auto');
        toggle.attr('class', 'click_toggle_vaqua up');
    } else {
        vgs.style('display', 'block');
        // ved.resizeVlEditor();
        toggle.attr('class', 'click_toggle_vaqua down');
    }
    // ved.resize();
};

ved.select = function (spec) {
    var $d3 = ved.$d3,
        mode = ved.currentMode,
        desc = $d3.select('.spec_desc'),
        editor = ved.editor[mode],
        sel = ved.getSelect(),
        parse = mode === VAQUA ? ved.parseVg : ved.parseVl;

    if (spec) {
        editor.setValue(spec);
        editor.gotoLine(0);
        desc.html('');
        parse();
        // ved.resizeVlEditor();
        return;
    }

    var idx = sel.selectedIndex;
    vaqua.modelID = idx;
    vaqua.displaySelect();
    spec = d3.select(sel.options[idx]).datum();

    function parallel_coord() {
        var path = "../" + vaqua.url.url.substr(6);
        $(".vaqua")
            .html('<object width="800" height="700" data="./../parallel-coords/index.html?path=' + path + '"/>').watch(600);
    }


    if (idx > 0) {
        if (idx == 26) {
            parallel_coord();
        }
        else {
            d3.xhr(ved.uri(spec), function (error, response) {

                var txt = vaqua.changeFields(response.responseText);

                editor.setValue(txt);
                editor.gotoLine(0);
                parse(function (err) {
                    if (err) console.error(err);
                    desc.html(spec.desc || '');
                });
                ved.format();
            });
        }
    } else {
        editor.setValue('');
        editor.gotoLine(0);
        ved.editor[VAQUA].setValue('');
        ved.resetView();
    }

    // if (mode === VAQUA) {
    //     ved.resize();
    // } else if (mode === 'vl') {
    //     ved.resizeVlEditor();
    // }
};

ved.uri = function (entry) {//simple pir chart for ex --- file pat

    if (entry == "") {
        return '../uploads/' + vaqua.q_id + "/dataset/" + vaqua.defaultName + "_conf.json";
    }
    else {
        return ved.path + 'spec/' + ved.currentMode +
            '/' + entry.name + '.json';
    }
};

ved.renderer = function () {
    var sel = ved.$d3.select('.sel_render').node(),
        idx = sel.selectedIndex,
        ren = sel.options[idx].value;

    ved.renderType = ren;
    ved.parseVg();
};

ved.format = function () {
    for (var key in ved.editor) {
        var editor = ved.editor[key];
        var text = editor.getValue();
        if (text.length) {
            var spec = JSON.parse(text);
            text = JSON3.stringify(spec, null, 2, 60);
            editor.setValue(text);
            editor.gotoLine(0);
        }
    }
};

ved.parseVl = function (callback) {
    var spec, source,
        value = ved.editor[VAQUA_LITE].getValue();

    // delete cookie if editor is empty
    if (!value) {
        localStorage.removeItem('vaqua-lite-spec');
        return;
    }

    try {
        spec = JSON.parse(value);
    } catch (e) {
        return;
    }

    if (ved.getSelect().selectedIndex === 0) {
        localStorage.setItem('vaqua-lite-spec', value);
    }

    // TODO: display error / warnings
    var vgSpec = vl.compile(spec).spec;
    var text = JSON3.stringify(vgSpec, null, 2, 60);
    ved.editor[VAQUA].setValue(text);
    ved.editor[VAQUA].gotoLine(0);

    // change select for vaqua to Custom
    var vgSel = ved.$d3.select('.sel_vaqua_spec');
    vgSel.node().selectedIndex = 0;

    ved.parseVg(callback);
};

ved.parseVg = function (callback) {
    if (!callback) {
        callback = function (err) {
            if (err) {
                if (ved.view) ved.view.destroy();
                console.error(err);
            }
        };
    }

    var opt, source,
        value = ved.editor[VAQUA].getValue();

    // delete cookie if editor is empty
    if (!value) {
        localStorage.removeItem('vaqua-spec');
        return;
    }

    try {
        opt = JSON.parse(ved.editor[VAQUA].getValue());
    } catch (e) {
        return callback(e);
    }

    if (ved.getSelect().selectedIndex === 0 && ved.currentMode === VAQUA) {
        localStorage.setItem('vaqua-spec', value);
    }

    if (!opt.spec && !opt.url && !opt.source) {
        // wrap spec for handoff to vaqua-embed
        opt = {spec: opt};
    }
    opt.actions = false;
    opt.renderer = opt.renderer || ved.renderType;
    opt.parameter_el = '.mod_params';

    ved.resetView();
    var a = vg.embed('.vis', opt, function (err, result) {
        if (err) return callback(err);
        ved.spec = result.spec;
        ved.view = result.view;
        callback(null, result.view);
    });

};

ved.resetView = function () {
    var $d3 = ved.$d3;
    if (ved.view) ved.view.destroy();
    $d3.select('.mod_params').html('');
    $d3.select('.spec_desc').html('');
    $d3.select('.vis').html('');
};

// ved.resize = function (event) {
//     // ved.editor[VAQUA].resize();
//     // ved.editor[VAQUA_LITE].resize();
// };
//
// ved.resizeVlEditor = function () {
//     if (ved.vgHidden || ved.currentMode !== VAQUA_LITE)
//         return;
//
//     var editor = ved.editor[VAQUA_LITE];
//     var height = editor.getSession().getDocument().getLength() *
//         editor.renderer.lineHeight + editor.renderer.scrollBar.getWidth();
//
//     if (height > 600) {
//         return;
//     } else if (height < 200) {
//         height = 200;
//     }
//
//     ved.$d3.select('.vl-spec')
//         .style('height', height + 'px')
//         .style('flex', 'none');
//     ved.resize();
// };

ved.setPermanentUrl = function () {
    var params = [];
    params.push('mode=' + ved.currentMode);

    var sel = ved.getSelect();
    var idx = sel.selectedIndex,
        spec = d3.select(sel.options[idx]).datum();

    if (spec) {
        params.push('spec=' + spec.name);
    }

    if (!ved.vgHidden && ved.currentMode === VAQUA_LITE) {
        params.push('showEditor=1');
    }

    if (ved.$d3.select('.sel_render').node().selectedIndex === 1) {
        params.push('renderer=svg');
    }

    var path = location.protocol + '//' + location.host + location.pathname;
    var url = path + '?id=' + vaqua.q_id + '&' + params.join('&');

    // vaqua

    //window.history.replaceState("", document.title, url);
};

ved.export = function () {
    var ext = ved.renderType === 'canvas' ? 'png' : 'svg',
        url = ved.view.toImageURL(ext);
    vaqua.dowloadOnServe(url);
};


vaqua.dowloadOnServe = function (dataUrl) {

    $.ajax({
        type: "POST",
        url: "script.php",
        data: {
            'img': dataUrl,
            'q_id': vaqua.q_id,
            'comment': vaqua.comment.value
        },
        dataType: "json"
    }).done(function (res) {
        window.location = "./../index.php?qa=" + vaqua.q_id + "&qa_1=" + res['title'] + "&start=" + res['start'] + "#a_list_title";
    });
}

ved.setUrlAfter = function (func) {
    return function () {
        func();
        ved.setPermanentUrl();
    };
};

ved.goCustom = function (func) {
    return function () {
        ved.getSelect().selectedIndex = 0;
        func();
    };
};

ved.getSelect = function () {
    return ved.$d3.select('.sel_' + ved.currentMode + '_spec').node();
};


ved.init = function (el, dir) {


    vaqua.init();

    // Set base directory
    var PATH = dir || 'app/';
    vg.config.load.baseURL = PATH;
    ved.path = PATH;

    el = (ved.$d3 = d3.select(el));

    d3.text(PATH + 'template.php' + '?' + Math.floor(Math.random() * 1000), function (err, text) {
        el.html(text);


        vaqua.initUpload();

        vaqua.initTextArea(el);

        // Vaqua specification drop-down menu
        var vgSel = el.select('.sel_vaqua_spec');
        vgSel.on('change', ved.setUrlAfter(ved.select));
        vgSel.append('option').text('Custom');
        vgSel.selectAll('optgroup')
            .data(Object.keys(VG_SPECS))
            .enter().append('optgroup')
            .attr('label', function (key) {
                return key;
            })
            .selectAll('option.spec')
            .data(function (key) {
                return VG_SPECS[key];
            })
            .enter().append('option')
            .text(function (d) {
                return d.name;
            });


        // Vaqua-lite specification drop-down menu
        var vlSel = el.select('.sel_vaqua-lite_spec');
        vlSel.on('change', ved.setUrlAfter(ved.select));
        vlSel.append('option').text('Custom');
        vlSel.selectAll('optgroup')
            .data(Object.keys(VL_SPECS))
            .enter().append('optgroup')
            .attr('label', function (key) {
                return key;
            })
            .selectAll('option.spec')
            .data(function (key) {
                return VL_SPECS[key];
            })
            .enter().append('option')
            .attr('label', function (d) {
                return d.title;
            })
            .text(function (d) {
                return d.name;
            });

        // Renderer drop-down menu
        var ren = el.select('.sel_render');
        ren.on('change', ved.setUrlAfter(ved.renderer));
        ren.selectAll('option')
            .data(['Canvas', 'SVG'])
            .enter().append('option')
            .attr('value', function (d) {
                return d.toLowerCase();
            })
            .text(function (d) {
                return d;
            });

        // Vaqua or Vaqua-lite mode
        var mode = el.select('.sel_mode');
        mode.on('change', ved.setUrlAfter(ved.mode));


        // Code Editors
        var vlEditor = ved.editor[VAQUA_LITE] = ace.edit(el.select('.vl-spec').node());
        var vgEditor = ved.editor[VAQUA] = ace.edit(el.select('.vg-spec').node());

        [vlEditor, vgEditor].forEach(function (editor) {
            editor.getSession().setMode('ace/mode/json');
            editor.getSession().setTabSize(2);
            editor.getSession().setUseSoftTabs(true);
            editor.setShowPrintMargin(false);
            editor.on('focus', function () {
                d3.selectAll('.ace_gutter-active-line').style('background', '#DCDCDC');
                d3.selectAll('.ace-tm .ace_cursor').style('visibility', 'visible');
            });
            editor.on('blur', function () {
                d3.selectAll('.ace_gutter-active-line').style('background', 'transparent');
                d3.selectAll('.ace-tm .ace_cursor').style('visibility', 'hidden');
                editor.clearSelection();
            });
            editor.$blockScrolling = Infinity;
            d3.select(editor.textInput.getElement())
                .on('keydown', ved.goCustom(ved.setPermanentUrl));

            editor.setValue('');
            editor.gotoLine(0);


        });

        // adjust height of vl editor based on content
        // vlEditor.on('input', ved.resizeVlEditor);
        // ved.resizeVlEditor();

        // Initialize application
        el.select('.btn_spec_format').on('click', ved.format);
        el.select('.btn_vg_parse').on('click', ved.setUrlAfter(ved.parseVg));
        el.select('.btn_vl_parse').on('click', ved.setUrlAfter(ved.parseVl));
        el.select('.btn_to_vaqua').on('click', ved.setUrlAfter(function () {
            d3.event.preventDefault();
            ved.switchToVaqua();
        }));
        el.select('.btn_export').on('click', ved.export);
        el.select('.vg_pane').on('click', ved.setUrlAfter(function () {
            ved.vgHidden = !ved.vgHidden;
            ved.editorVisibility();
        }));


        // d3.select(window).on('resize', ved.resize);
        // ved.resize();

        var getIndexes = function (obj) {
            return Object.keys(obj).reduce(function (a, k) {
                return a.concat(obj[k].map(function (d) {
                    return d.name;
                }));
            }, []);
        };

        ved.specs = {};
        ved.specs[VAQUA] = getIndexes(VG_SPECS);
        ved.specs[VAQUA_LITE] = getIndexes(VL_SPECS);

        // Handle application parameters
        var p = ved.params();
        if (p.renderer) {
            ren.node().selectedIndex = p.renderer.toLowerCase() === 'svg' ? 1 : 0;
            ved.renderType = p.renderer;
        }

        if (p.mode) {
            mode.node().selectedIndex = p.mode.toLowerCase() === VAQUA ? 1 : 0;
        }
        ved.mode();

        if (ved.currentMode === VAQUA_LITE) {
            if (p.showEditor) {
                ved.vgHidden = false;
                ved.editorVisibility();
            }
        }

        if (p.spec) {
            var spec = decodeURIComponent(p.spec),
                idx = ved.specs[ved.currentMode].indexOf(spec) + 1;

            if (idx > 0) {
                ved.getSelect().selectedIndex = idx;
                ved.select();
            } else {
                try {
                    var json = JSON.parse(decodeURIComponent(spec));
                    ved.select(spec);
                    ved.format();
                } catch (err) {
                    console.error(err);
                    console.error('Specification loading failed: ' + spec);
                }
            }
        }


        window.addEventListener('message', function (evt) {
            var data = evt.data;

            // send acknowledgement
            if (data.spec || data.file) {
                evt.source.postMessage(true, '*');
            }

            // set vg or vl mode
            if (data.mode) {
                mode.node().selectedIndex =
                    data.mode.toLowerCase() === VAQUA_LITE ? 1 : 0;
                ved.mode();
            }

            // load spec
            if (data.spec) {
                ved.select(data.spec);
            } else if (data.file) {
                ved.getSelect().selectedIndex = ved.specs[ved.currentMode].indexOf(data.file) + 1;
                ved.select();
            }


        }, false);
        vaqua.initVaquaJson();
    });


};

vaqua.trackMouseMove = function (e) {
    vaqua.mouseMovedY = e.y;
    vaqua.mouseMovedX = e.x;

}

vaqua.trackMouseClick = function (e) {
    vaqua.mouseClickedY = e.y;
    vaqua.mouseClickedX = e.x;
}

vaqua.init = function () {

    document.addEventListener("mousemove", vaqua.trackMouseMove);
    document.addEventListener("mousedown", vaqua.trackMouseClick);
    document.addEventListener("mouseup", vaqua.tarckMouseUp);
    vaqua.q_id = vaqua.findGetParameter('id');
    vaqua.defaultName = vaqua.findGetParameter('name');
}

vaqua.initVaquaJson = function () {
    var $d3 = ved.$d3,
        mode = ved.currentMode,
        desc = $d3.select('.spec_desc'),
        editor = ved.editor[VAQUA],
        sel = ved.getSelect(),
        parse = mode === VAQUA ? ved.parseVg : ved.parseVl;

    var spec = d3.select(sel.options[5]).datum();

    d3.xhr(ved.uri(""), function (error, response) {

        var text = vaqua.changeFields(response.responseText);

        editor.setValue(text);
        ved.select(text);
        editor.gotoLine(0);
        ved.format();
    });
};


vaqua.changeFields = function (jsonTxt) {
    var jsonObj = JSON.parse(jsonTxt);


    jsonObj = vaqua.parseConfJson(jsonObj);

    var text = JSON.stringify(jsonObj);

    return text;
}
vaqua.drawData = function (jsonObj) {
    var dimensions;
    $(document).ready(function () {

        var pathh = "../" + vaqua.url.url.substr(6);


        var margin = {top: 20, right: 10, bottom: 10, left: 10},
            width = 530 - margin.left - margin.right,
            height = 200 - margin.top - margin.bottom;

        var x = d3.scale.ordinal().rangePoints([0, width], 1),
            y = {},
            dragging = {};

        var line = d3.svg.line(),
            axis = d3.svg.axis().orient("left"),
            background,
            foreground;

        d3.select(".gui_rep").select("svg").remove();
        var svg = d3.select(".gui_rep").append("svg")
            .attr("width", width + margin.left + margin.right)
            .attr("height", height + margin.top + margin.bottom)
            .append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")")
            .style("font", "10px sans-serif");

        //var pathh = vaqua.findGetParameter("path");
        d3.json(pathh, function (error, data) {


            x.domain(dimensions = d3.keys(data[0]).filter(function (d) {

                //if (typeof data[0][d] != "string") {
                if(_.isNumber(data[0][d])){
                    return ( y[d] = d3.scale.linear()
                        .domain(d3.extent(data, function (p) {
                            return +p[d];
                        }))
                        .range([height, 0]));
                }
                else if( typeof data[0][d] === "string"){
                    console.log(data.map(function(s){ 
                            return s[d];}).sort());
                    return (y[d] = d3.scale.ordinal()
                        .domain(data.map(function(s){ 
                            return s[d];}).sort())
                        .rangePoints([0,height]));
                }
                vaqua.realData = data;
            }));

            // Add grey background lines for context.
            background = svg.append("g")
                .attr("class", "background")
                .selectAll("path")
                .data(data)
                .enter().append("path")
                .attr("d", path)
                .style("fill", "none")
                .style("stroke", "#ddd");

            // Add blue foreground lines for focus.
            foreground = svg.append("g")
                .attr("class", "foreground")
                .selectAll("path")
                .data(data)
                .enter().append("path")
                .attr("d", path)
                .style("fill", "none")
                .style("stroke", "steelblue");
            // Add a group element for each dimension.
            var g = svg.selectAll(".dimension")
                .data(dimensions)
                .enter().append("g")
                .attr("class", "dimension")
                .attr("transform", function (d) {
                    return "translate(" + x(d) + ")";
                })
                .call(d3.behavior.drag()
                    .origin(function (d) {
                        return {x: x(d)};
                    })
                    .on("dragstart", function (d) {

                        dragging[d] = x(d);
                        vaqua.beginDrag(Object.keys(dragging)[0]);
                        background.attr("visibility", "hidden");
                    })
                    .on("drag", function (d) {
                        vaqua.drag();
                        dragging[d] = Math.min(width, Math.max(0, d3.event.x));
                        foreground.attr("d", path);
                        dimensions.sort(function (a, b) {
                            return position(a) - position(b);
                        });
                        x.domain(dimensions);
                        g.attr("transform", function (d) {
                            return "translate(" + position(d) + ")";
                        });
                    })
                    .on("dragend", function (d) {
                        vaqua.endDrag();
                        delete dragging[d];
                        transition(d3.select(this)).attr("transform", "translate(" + x(d) + ")");
                        transition(foreground).attr("d", path);
                        background
                            .attr("d", path)
                            .transition()
                            .delay(500)
                            .duration(0)
                            .attr("visibility", null);
                    }));

            // Add an axis and title.
            g.append("g")
                .attr("class", "axis")
                .style("fill", "none")
                .style("stroke", "#000")
                .style("shape-rendering", "crispEdges")
                .each(function (d) {
                    d3.select(this).call(axis.scale(y[d]));
                })
                .append("text")
                .style("text-anchor", "middle")
                //.style("text-shadow", "0 1px 0 #fff, 1px 0 0 #fff, 0 -1px 0 #fff, -1px 0 0 #fff")
                .style("cursor", "move")
                .attr("y", -9)
                .text(function (d) {
                    return d;
                });

            // Add and store a brush for each axis.
            g.append("g")
                .attr("class", "brush")
                .style("fill-opacity", .3)
                .style("stroke", "#fff")
                .style("shape-rendering", "crispEdges")
                .each(function (d) {
                    d3.select(this).call(y[d].brush = d3.svg.brush().y(y[d]).on("brushstart", brushstart).on("brush", brush));

                })
                .selectAll("rect")
                .attr("x", -8)
                .attr("width", 16);
        });

        function isAstring(s){
            for (var i = 0; i < s.length; i++){
                var ch = s.charAt(i);
                if (ch >= 'a' && ch <= 'z'){
                    return true;
                }
            }
            return false;
        }

        function position(d) {
            var v = dragging[d];
            return v == null ? x(d) : v;
        }

        function transition(g) {
            return g.transition().duration(500);
        }

        // Returns the path for a given data point.
        function path(d) {
            return line(dimensions.map(function (p) {
                return [position(p), y[p](d[p])];
            }));
        }

        function brushstart() {
            vaqua.brushStart = true;
            d3.event.sourceEvent.stopPropagation();
        }

        // Handles a brush event, toggling the display of foreground lines.
        function brush() {

            var actives = dimensions.filter(function (p) {
                    return !y[p].brush.empty();
                }),
                extents = actives.map(function (p) {
                    return y[p].brush.extent();
                });
            foreground.style("display", function (d) {
                return actives.every(function (p, i) {
                    return extents[i][0] <= d[p] && d[p] <= extents[i][1];
                }) ? null : "none";
            });
            vaqua.fields = {};
            //vaqua.fields.actives = actives;
            // vaqua.fields.sData = extents;
            var data = {};
            var title, titles = [];
            for (var i = 0; i < actives.length; i++) {
                title = actives[i];
                titles.push(title);
                data[title] = extents[i];
            }
            vaqua.data = data;
            vaqua.titles = titles;
            vaqua.draw = true;
            vaqua.pathOfBruch = pathh;


        }

        // $(".gui_rep")
        //   .html('<object width="520px" height="220px" data="./../parallel-coords/index.html?path='+path+'"/>');
    });
};

vaqua.drawOnBrush = function () {
    $.ajax({
        url: './../vaqua/temp.php',
        type: 'POST',
        data: {
            dataPath: vaqua.pathOfBruch,
            sdata: vaqua.data,
            titles: vaqua.titles
        },
        success: function (res) {
            vaqua.defaultName = res;
            vaqua.initVaquaJson();
            vaqua.url = "";

        }
    });
}

vaqua.beginDrag = function (dragedElement) {

    vaqua.dragMode = true;
    $("body").css("cursor", "none");
    $(".dragIcon").css("top", vaqua.mouseMovedY);
    $(".dragIcon").css("left", vaqua.mouseMovedX);
    $(".dragIcon").show();
    vaqua.dragedElement = dragedElement;
};

vaqua.drag = function () {
    $(".dragIcon").css("top", vaqua.mouseMovedY);
    $(".dragIcon").css("left", vaqua.mouseMovedX);
};

vaqua.endDrag = function () {
    vaqua.dragMode = false;
    $("body").css("cursor", "auto");
    $(".dragIcon").hide();
};

vaqua.findGetParameter = function (parameterName) {
    var result = null,
        tmp = [];
    location.search
        .substr(1)
        .split("&")
        .forEach(function (item) {
            tmp = item.split("=");
            if (tmp[0] === parameterName) result = decodeURIComponent(tmp[1]);
        });
    return result;
}

vaqua.parseConfJson = function (jsonObj) {
    if (!vaqua.url) {
        vaqua.url = jsonObj['data'];
        vaqua.x = jsonObj['encoding']['x']['field'];
        vaqua.y = jsonObj['encoding']['y']['field'];
        vaqua.typeX = jsonObj['encoding']['x']['type'];
        vaqua.typeY = jsonObj['encoding']['y']['type'];

        vaqua.color = jsonObj['encoding']['color']['field'];
        vaqua.colorType = jsonObj['encoding']['color']['type'];

        vaqua.text = jsonObj['encoding']['text']['field'];
        vaqua.textType = jsonObj['encoding']['text']['type'];
        vaqua.attr = jsonObj['attr'];

        vaqua.keys = [];
        vaqua.values = [];
        if (!vaqua.draw) {
            vaqua.drawData(jsonObj);
        }

        for (var i = 0; i < Object.keys(vaqua.attr).length; i++) {
            vaqua.keys[i] = Object.keys(vaqua.attr)[i];
        }

        for (var i = 0; i < Object.values(vaqua.attr).length; i++) {
            vaqua.values[i] = Object.values(vaqua.attr)[i]
        }

        vaqua.typex = vaqua.values[0];
        vaqua.typey = vaqua.values[1];

        vaqua.displaySelect();
        vaqua.initKeysSelect();

        delete jsonObj['attr'];


    }

    if (jsonObj['encoding']['x']['axis']) {
        delete jsonObj['encoding']['x']['axis'];
    }

    if (jsonObj['encoding']['x']['timeUnit']) {
        delete jsonObj['encoding']['x']['timeUnit'];
    }

    if (jsonObj['encoding']['y']['axis']) {
        delete jsonObj['encoding']['y']['axis'];
    }

    if (jsonObj['encoding']['y']['timeUnit']) {
        delete jsonObj['encoding']['y']['timeUnit'];
    }

    var url = vaqua.url;
    var i = 0;
    var optio = ["s", "l", "m", "n", "o"];


    jsonObj['data'] = url;
    jsonObj['transform'] = "";
    var obj = jsonObj['encoding'];

    if (obj) {
        if (obj['x']) {
            obj['x']['field'] = vaqua.x;
            obj['x']['type'] = vaqua.typeX;
        }
        if (obj['y']) {
            obj['y']['field'] = vaqua.y;
            obj['y']['type'] = vaqua.typeY;
        }


        if (obj['text']) {
            obj['text']['field'] = vaqua.text || vaqua.x;
            obj['text']['type'] = vaqua.textType;
        }
        if (obj['color']) {
            obj['color']['field'] = vaqua.color || vaqua.y;
            obj['color']['type'] = vaqua.colorType;
        }
        if (obj['size']) {
            obj['size']['field'] = vaqua.y;
            obj['size']['type'] = vaqua.typeY;
        }
    }

    return jsonObj
}

vaqua.initTextArea = function (el) {

    var txtArea = el.select("#comment")[0][0];
    vaqua.comment = txtArea;
    var documentWidth = $(document).width();
    var documentHeight = $(document).height();
    var txtAreaWidth = vaqua.cumulativeOffset(txtArea).left;
    var txtAreaHeight = vaqua.cumulativeOffset(txtArea).top;
    txtArea.style.width = (documentWidth - txtAreaWidth) + "px";
    txtArea.style.height = (documentHeight - txtAreaHeight - 400) + "px";
};

vaqua.cumulativeOffset = function (element) {
    var top = 0, left = 0;
    do {
        top += element.offsetTop || 0;
        left += element.offsetLeft || 0;
        element = element.offsetParent;
    } while (element);

    return {
        top: top,
        left: left
    };
};

vaqua.initUpload = function () {
    $("#upload").change(function () {
        vaqua.draw = false;
        var file_data = $('#upload').prop('files')[0];
        var form_data = new FormData();
        form_data.append('file', file_data);

        $.ajax({
            url: './app/vaqua/upload.php', // point to server-side PHP script
            dataType: 'text',  // what to expect back from the PHP script, if anything
            cache: false,
            contentType: false,
            processData: false,
            data: form_data,
            type: 'post',
            success: function (res) {
                vaqua.defaultName = res;
                vaqua.initVaquaJson();
                vaqua.url = "";

            }
        });
    });
};

vaqua.initKeysSelect = function () {

    vaqua.initKeysSelect.onChange = function (k, value, type) {
        if (k == "x") {
            vaqua.x = value;
            vaqua.typeX = type;
        }
        if (k == "y") {
            vaqua.y = value;
            vaqua.typeY = type;
        }
        if (k == "color") {
            vaqua.color = value;
        }
        if (k == "text") {
            vaqua.text = value;
        }
        if (vaqua.modelID) {
            ved.select("");
        } else {
            vaqua.initVaquaJson();
        }

    }

    $(document).ready(function () {
        clearAll();
        var firstEnter = 0;
        for (var i = 0; i < vaqua.keys.length; i++) {
            if (vaqua.values[i] != "nominal") {
                if (firstEnter == 0) {
                    vaqua.initKeysSelect.onChange("x", vaqua.keys[i], vaqua.values[i]);
                    vaqua.initKeysSelect.onChange("y", vaqua.keys[i], vaqua.values[i]);
                    firstEnter = 5;
                }
                $("#attrselectorx").append("<option class='" + vaqua.values[i] + "'>" + vaqua.keys[i] + "</option>");
                $("#attrselectory").append("<option class='" + vaqua.values[i] + "'>" + vaqua.keys[i] + "</option>");
            }
            $('#attrselectorsize').append("<option class='" + vaqua.values[i] + "'>" + vaqua.keys[i] + "</option>");
            $('#attrselectorcolor').append("<option class='" + vaqua.values[i] + "'>" + vaqua.keys[i] + "</option>");
            $('#attrselectorshape').append("<option class='" + vaqua.values[i] + "'>" + vaqua.keys[i] + "</option>");
            $('#attrselectortext').append("<option class='" + vaqua.values[i] + "'>" + vaqua.keys[i] + "</option>");

        }

        $("#attrselectorx").change(function () {
            vaqua.initKeysSelect.onChange("x", $(this).val(), $(this).attr("class"));
        });

        $("#attrselectorx").mouseenter(function () {
            if (vaqua.dragMode) {
                vaqua.mouseOverselectorX = true;
                $(this).css("border", "1px solid yellow");
            }
        });
        $("#attrselectorx").mouseleave(function () {
            var ele = $(this);
            setTimeout(function () {
                vaqua.mouseOverselectorX = false;
                ele.css("border", "1px solid black");
            }, 1);

        });
        $("#attrselectory").change(function () {
            vaqua.initKeysSelect.onChange("y", $(this).val(), $(this).attr("class"));
        });
        $("#attrselectory").mouseenter(function () {
            if (vaqua.dragMode) {
                vaqua.mouseOverselectorY = true;
                $(this).css("border", "1px solid yellow");
            }
        });
        $("#attrselectory").mouseout(function () {
            var ele = $(this);
            setTimeout(function () {
                vaqua.mouseOverselectorX = false;
                ele.css("border", "1px solid black");
            }, 1);
        });
        $('#attrselectorsize').change(function () {
            vaqua.initKeysSelect.onChange("size", $(this).val(), $(this).attr("class"));
        });
        $("#attrselectorsize").mouseover(function () {
            if (vaqua.dragMode) {
                vaqua.mouseOverselectorSize = true;
                $(this).css("border", "1px solid yellow");
            }
        });
        $("#attrselectorsize").mouseout(function () {
            var ele = $(this);
            setTimeout(function () {
                vaqua.mouseOverselectorX = false;
                ele.css("border", "1px solid black");
            }, 1);
        });
        $('#attrselectorcolor').change(function () {
            vaqua.initKeysSelect.onChange("color", $(this).val(), $(this).attr("class"));
        });
        $("#attrselectorcolor").mouseover(function () {
            if (vaqua.dragMode) {
                vaqua.mouseOverselectorColor = true;
                $(this).css("border", "1px solid yellow");
            }
        });
        $("#attrselectorcolor").mouseout(function () {
            var ele = $(this);
            setTimeout(function () {
                vaqua.mouseOverselectorX = false;
                ele.css("border", "1px solid black");
            }, 1);
        });
        $('#attrselectorshape').change(function () {
            vaqua.initKeysSelect.onChange("shape", $(this).val(), $(this).attr("class"));
        });
        $("#attrselectorshape").mouseover(function () {
            if (vaqua.dragMode) {
                vaqua.mouseOverselectorShape = true;
                $(this).css("border", "1px solid yellow");
            }
        });
        $("#attrselectorshape").mouseout(function () {
            var ele = $(this);
            setTimeout(function () {
                vaqua.mouseOverselectorX = false;
                ele.css("border", "1px solid black");
            }, 1);
        });
        $('#attrselectortext').change(function () {
            vaqua.initKeysSelect.onChange("text", $(this).val(), $(this).attr("class"));
        });
        $("#attrselectortext").mouseover(function () {
            if (vaqua.dragMode) {
                vaqua.mouseOverselectorText = true;
                $(this).css("border", "1px solid yellow");
            }
        });
        $("#attrselectortext").mouseout(function () {
            var ele = $(this);
            setTimeout(function () {
                vaqua.mouseOverselectorX = false;
                ele.css("border", "1px solid black");
            }, 1);
        });
    });


    function clearAll() {
        $("#attrselectorx").html("");
        $("#attrselectory").html("");
        $('#attrselectorsize').html("");
        $('#attrselectorcolor').html("");
        $('#attrselectorshape').html("");
        $('#attrselectortext').html("");
    }
};

vaqua.tarckMouseUp = function () {

    if (vaqua.brushStart){
        vaqua.drawOnBrush();
        vaqua.brushStart = false;
    }
    if (vaqua.mouseOverselectorX) {
        $("#attrselectorx").val(vaqua.dragedElement);
        var selectKey = $("#attrselectorx").find(":selected").attr("class");
        vaqua.initKeysSelect.onChange("x", vaqua.dragedElement, selectKey);
    }
    else if (vaqua.mouseOverselectorY) {
        $("#attrselectory").val(vaqua.dragedElement);
        var selectKey = $("#attrselectory").find(":selected").attr("class");
        vaqua.initKeysSelect.onChange("y", vaqua.dragedElement, selectKey);
    }
    else if (vaqua.mouseOverselectorSize) {
        $("#attrselectorsize").val(vaqua.dragedElement);
        var selectKey = $("#attrselectorsize").find(":selected").attr("class");
        vaqua.initKeysSelect.onChange("size", vaqua.dragedElement, selectKey);
    } else if (vaqua.mouseOverselectorColor) {
        $("#attrselectorcolor").val(vaqua.dragedElement);
        var selectKey = $("#attrselectorcolor").find(":selected").attr("class");
        vaqua.initKeysSelect.onChange("color", vaqua.dragedElement, selectKey);
    } else if (vaqua.mouseOverselectorShape) {
        $("#attrselectorshape").val(vaqua.dragedElement);
        var selectKey = $("#attrselectorshape").find(":selected").attr("class");
        vaqua.initKeysSelect.onChange("shape", vaqua.dragedElement, selectKey);
    } else if (vaqua.mouseOverselectorText) {
        $("#attrselectortext").val(vaqua.dragedElement);
        var selectKey = $("#attrselectortext").find(":selected").attr("class");
        vaqua.initKeysSelect.onChange("text", vaqua.dragedElement, selectKey);
    }

}


vaqua.displaySelect = function () {
    $(document).ready(function () {
        var idx = vaqua.modelID || 1;
        hideAll();
        if (idx == 14){
            $("#attrtitle").parent().show();
            $("#attrselectorx").parent().show();
        }
        else if(idx == 16){
            $("#attrtitle").parent().show();
            $('#attrselectorx').parent().show();
            $('#attrselectorcolor').parent().show();
        }
        else if (idx == 1 || idx == 2 || idx == 3 || idx == 5 || idx == 4 || idx == 9 || idx == 10 || idx == 11  || idx == 15) {
          $("#attrtitle").parent().show();
            $("#attrselectorx").parent().show();
            $("#attrselectory").parent().show();
        }
        else if ( idx == 8) {
            $("#attrtitle").parent().show();
            $('#attrselectorx').parent().show();
            $('#attrselectory').parent().show();
            $('#attrselectorsize').parent().show();

        }
        else if (idx == 12 || idx == 13 || idx == 17 || idx == 18 || idx == 19 || idx == 20 || idx == 21 || idx == 22 || idx == 24 || idx == 25) {
            $("#attrtitle").parent().show();
            $('#attrselectorx').parent().show();
            $('#attrselectory').parent().show();
            $('#attrselectorcolor').parent().show();

        }
        else if (idx == 6) {
            $("#attrtitle").parent().show();
            $('#attrselectorx').parent().show();
            $('#attrselectory').parent().show();
            $('#attrselectorcolor').parent().show();
            $('#attrselectorshape').parent().show();

        }
        else if (idx == 23) {
            $("#attrtitle").parent().show();
            $('#attrselectorx').parent().show();
            $('#attrselectory').parent().show();
            $('#attrselectorcolor').parent().show();
            $('#attrselectorsize').parent().show();

        }
        else if (idx == 7) {
            $("#attrtitle").show();
            $('#attrselectorx').show()
            $('#attrselectory').show();
            $('#attrselectorcolor').show();
            $('#attrselectortext').show();

        }


    });

    function hideAll() {
        $("#attrtitle").parent().hide();
        $("#attrselectorx").parent().hide();
        $("#attrselectory").parent().hide();
        $('#attrselectorsize').parent().hide();
        $('#attrselectorcolor').parent().hide();
        $('#attrselectorshape').parent().hide();
        $('#attrselectortext').parent().hide();
    }

};

function allowDrop(ev) {
    ev.preventDefault();
}

function drag(ev) {
    ev.dataTransfer.setData("text", ev.target.id);
}

function drop(ev) {
    ev.preventDefault();
    var data = ev.dataTransfer.getData("text");
    ev.target.appendChild(document.getElementById(data));
}
