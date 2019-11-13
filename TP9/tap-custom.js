////////////////////////////////////////////////////////////////
// String matchers
function is_empty_string(str) {
    return ((str == undefined) || (str === ""));
}
function is_correct_mail(mail) {
    var re = /^([\w]+)@([\w]+)\.([\w]+)$/i;
    return re.test(mail);
}
function is_correct_url(url) {
    var re = /^http(s)?:\/\/([\w]+)(\.[\w]+)*$/i;
    return re.test(url);
}

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
function init_fields() {
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
        if (test(d)) {
            return d;
        }
        else {
            d["error_id"] = id;
            d["error_msg"] = msg;
            return Promise.reject(d);
        }
    }
}

////////////////////////////////////////////////////////////////
// Check the form with promises
function check_form_promise() {
    clear_errors();
    var firstname = $('#first_name').val();
    var lastname = $('#last_name').val();
    var email = $('#email').val();
    var webaddr = $('#webaddr').val();

    var p = () => Promise.resolve({}). // Dictionary that is transmitted
        then (promise_store ("firstname")).
        then (promise_check (d => !is_empty_string(d["firstname"]), 
    "firstname", "First name missing")).
    then(console.log(d)).
    catch (e => console.error(e))
        // .then((d) => {
        //     if (!is_empty_string(firstname)) {
        //         d["firstname"] = firstname;
        //         console.log(d);

        //         return d;
        //     }
        //     else {
        //         d["error"] = "First name missing";
        //         return d;
        //     }
        // }).then((d) => {
        //     if (!is_empty_string(lastname)) {
        //         d["lastname"] = lastname;
        //         console.log(d);

        //         return d;
        //     }
        //     else {
        //         d["error"] = "Last name missing";
        //         return d;
        //     }
        // }).then((d) => {
        //     if (is_correct_mail(email)) {
        //         d["email"] = email;
        //         console.log(d);

        //         return d;
        //     }
        //     else {
        //         d["error"] = "Email is missing";
        //         return d;
        //     }
        // }).then((d) => {
        //     if (is_correct_url(webaddr)) {
        //         d["webaddr"] = webaddr;
        //         console.log(d);

        //         return d;
        //     }
        //     else {
        //         d["error"] = "Web adress is missing";
        //         return d;
        //     }
        // })
        // .then((d) => console.log(d))
        // .catch(e => alert(error))

    p(); // Execute promise
}