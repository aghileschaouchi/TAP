////////////////////////////////////////////////////////////////
// String matchers
function is_empty_string(str) {
    return ((str == undefined) || (str === "")); }
function is_correct_mail(mail) {
    var re = /^([\w]+)@([\w]+)\.([\w]+)$/i;
    return re.test(mail); }
function is_correct_url(url) {
    var re = /^http(s)?:\/\/([\w]+)(\.[\w]+)*$/i;
    return re.test(url); }

////////////////////////////////////////////////////////////////
// Error helper function
function error(div, message) { $("#" + div).html(message); }

////////////////////////////////////////////////////////////////
// Check the form in an imperative manner
function check_form_imp() {
    clear_errors();
    var is_error = false;
    var firstname = $('#first_name').val();
    if (is_empty_string(firstname)) {
        error("first_name_error", "First name is empty");
        is_error = true;
    }
    var lastname = $('#last_name').val();
    if (is_empty_string(lastname)) {
        error("last_name_error", "Last name is empty");
        is_error = true;
    }
    var email = $('#email').val();
    if (!(is_correct_mail(email))) {
        error("email_error", "Email is not correct : '" + email + "'");
        is_error = true;
    }
    var webaddr = $('#webaddr').val();
    if (!(is_correct_url(webaddr))) {
        error("webaddr_error", "Web address is not correct : '" + webaddr + "'");
        is_error = true;
    }
    if (!is_error) {
	$('#result_imp').html("<pre>{ first:\"" + firstname +
                              "\"; last:\"" + lastname +
                              "\"; mail:\"" + email +
                              "\"; web:\"" + webaddr + "\" }</pre>");
    }
}

////////////////////////////////////////////////////////////////
// Clear all fields
function clear_errors() {
    $(".error").html("");
    $('#result_imp').html("");
    $('#result_promise').html("");
}
function clear_fields() { $(":input").val(""); clear_errors(); }
////////////////////////////////////////////////////////////////
// Initialize fields with given values
function init_fields()  {
    $("#first_name").val("Val");
    $("#last_name").val("Kilmer");
    $("#email").val("to@pg.un");
    $("#webaddr").val("https://wwwvalkilmercom");
}

////////////////////////////////////////////////////////////////
// Helpers
function promise_store(string) {
    return d => { d[string] = $('#' + string).val(); return d; }
}
function promise_check(test, id, msg) {
    return d => {
	if (test(d))
	    return d;
	else {
	    d["error_id"] = id;
	    d["error_msg"] = msg;
	    return Promise.reject(d);
	}}
}


////////////////////////////////////////////////////////////////
// Check the form with promises
// style de programmation "Continuation Passing Style" : promesses en JS
// construction de file d'exécution. on peut continuer à exécuter le reste du code 
// en attendant la résolution du code
// 
function check_form_promise_opt() {
    clear_errors();
    var firstname = 'first_name';
    var last = 'last_name';
    var email = 'email';
    var webaddr = 'webaddr';

    var p = () => Promise.resolve({}) // Dictionary that is transmitted
    .then(promise_store('first_name'))
    .then(promise_check(d => !is_empty_string(d["first_name"]),"first_name_err","first name missing"))
    .then(promise_store('last_name')) 
    .then(promise_check(d => !is_empty_string(d["last_name"]),"last_name_error","last name missing")) 
    .then(promise_store('email')) 
    .then(promise_check(d => is_correct_mail(d["email"]),"email_err","email invalid")) 
    .then(promise_store('webaddr')) 
    .then(promise_check(d => is_correct_url(d["webaddr"]),"webaddr_err","webaddr invalid")) 
    
    
    
    .then(d => console.log(d))

    .catch(err => console.error(err))
    ;
    p(); // Execute promise
}

function check_form_promise() {
    clear_errors();
    var p = () => Promise.resolve({}) // Dictionary that is transmitted
    .then((d) => {
        d["firstname"] = $('#first_name').val();
        if(!is_empty_string($('#first_name').val())){
            return d;
        }
        else{
            d["error"] = "first name missing";
            return d;
        }
    }).then((d) => { 
        d["lastname"] = $('#last_name').val();
        if(!is_empty_string($('#last_name').val())){
            return d;
        }
        else{
            d["error"] = "last name missing";
            return d;
        }
    }).then((d) => {
        d["email"] = $('#email').val();
        if(is_correct_mail($('#email').val())){
            return d;
        }
        else{
            d["error"] = "email not valid";
            return d;
        }
    }).then((d) => {
        d["webpage"] = $('#email').val();
        if(is_correct_url($('#webaddr').val())){
            return d;
        }
        else{
            d["error"] = "webpage not valid";
            return d;
        }
    
    }).then((d) => {
        console.log(d);

    }).catch((err) => {
        console.log("error");
    })
    p(); // Execute promise
}

