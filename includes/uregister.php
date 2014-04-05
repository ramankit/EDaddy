<form class="form-horizontal">
    <fieldset>

        <!-- Form Name -->
        <legend>Create my account!</legend>

        <!-- Text input-->
        <div class="form-group required-control">
            <label class="col-md-3 control-label" for="fName">First Name</label>
            <div class="col-md-3">
                <input id="fName" name="fName" type="text" placeholder="Enter first name" class="form-control " required="">

            </div>
        </div>

        <!-- Text input-->
        <div class="form-group">
            <label class="col-md-3 control-label" for="mName">Middle Name</label>
            <div class="col-md-3">
                <input id="mName" name="mName" type="text" placeholder="Enter middle name" class="form-control ">

            </div>
        </div>

        <!-- Text input-->
        <div class="form-group required-control">
            <label class="col-md-3 control-label" for="lName">Last Name</label>
            <div class="col-md-3">
                <input id="lName" name="lName" type="text" placeholder="Enter last name" class="form-control " required="">

            </div>
        </div>

        <div class="form-group required-control">
            <label class="col-md-3 control-label" for="dob">Birthday</label>

            <div class="col-md-3" id="sandbox-container"><div class="input-group date">
                    <input type="text" class="form-control" name="dob"><span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
                </div></div>
        </div>

        <!-- Text input-->
        <div class="form-group required-control">
            <label class="col-md-3 control-label" for="email">E-Mail</label>
            <div class="col-md-3">
                <input id="email" name="email" type="text" placeholder="Enter email id" class="form-control " required="">

            </div>
        </div>

        <!-- Text input-->
        <div class="form-group required-control">
            <label class="col-md-3 control-label" for="aemail">Alternate E-mail</label>
            <div class="col-md-3">
                <input id="aemail" name="aemail" type="text" placeholder="Enter alternate email id" class="form-control " required="">

            </div>
        </div>


        <!-- Password input-->
        <div class="form-group required-control">
            <label class="col-md-3 control-label" for="pwd">Password</label>
            <div class="col-md-3">
                <input id="pwd" name="pwd" type="password" placeholder="Create a password" class="form-control " required="">

            </div>
        </div>

        <!-- Password input-->
        <div class="form-group required-control">
            <label class="col-md-3 control-label" for="rpwd">Retype password</label>
            <div class="col-md-3">
                <input id="rpwd" name="rpwd" type="password" placeholder="Re type the password" class="form-control " required="">

            </div>
        </div>

        <!-- Text input-->
        <div class="form-group required-control">
            <label class="col-md-3 control-label" for="secQus">Security question</label>
            <div class="col-md-3">
                <input id="secQus" name="secQus" type="text" placeholder="Create a security question?" class="form-control " required="">

            </div>
        </div>

        <!-- Text input-->
        <div class="form-group required-control">
            <label class="col-md-3 control-label" for="secAns">Answer</label>
            <div class="col-md-3">
                <input id="secAns" name="secAns" type="text" placeholder="Answer to above question is" class="form-control " required="">

            </div>
        </div>

        <!-- Button (Double) -->
        <div class="form-group">
            <label class="col-md-3 control-label" for="register"></label>
            <div class="col-lg-6">
                <button id="register" name="register" class="btn btn-primary">Create account</button>
                <button id="reset" name="reset" class="btn btn-danger">Clear the fields</button>
            </div>
        </div>
    </fieldset>
</form>
<script>

    $('#sandbox-container .input-group.date').datepicker({
    });
</script>