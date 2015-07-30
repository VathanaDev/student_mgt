<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Student Management</title>
		
        <link rel="stylesheet" href="vendor/bootstrap/css/bootstrap.css"/>
        <link rel="stylesheet" href="dist/css/formValidation.css"/>
        <script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>
        <script type="text/javascript" src="vendor/bootstrap/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="dist/js/formValidation.js"></script>
        <script type="text/javascript" src="dist/js/framework/bootstrap.js"></script>
		<!--<script src="js/jquery-1.9.1.min.js" type="text/javascript"></script>
		<script src="js/bootstrap.min.js" type="text/javascript"></script>
		<link rel="stylesheet" href="css/bootstrap.min.css">-->
		<link href="css/style.css" rel="stylesheet">
		
		<!-- sweet alert -->
		<script src="js/sweetalert.min.js"></script> 
		<link rel="stylesheet" type="text/css" href="css/sweetalert.css">
	</head>
	<body>
		<div class="container">
			<div class="page-header"><h1>Student Management</h1></div>
			<div class='panel panel-primary'>
				<div class="head form-inline panel-heading">
					<!--search-->
					<div class="form-group">
						<label for="search">Search by Name: </label>
						<input class='form-control' type="text" id="txt_search" name="txt_search" placeholder="eg: Lun Sovathana">
					</div>
					
					<!--class-->
					<select class='form-control' name="txt_class" id="txt_class" onchange="search()">
						
					</select>
					
					<!--status-->
					<select class='form-control' name="txt_status" id="txt_status" onchange="search()">
						<option value="all">All Status</option>
						<option value="1">Active</option>
						<option value="0">Deactive</option>
					</select>
					
					<!-- button add -->
					<input class='btn btn-default' type="button" id="btn_add" value="New" title="Add New Student" onclick="changeModal(this);" data-toggle="modal" data-target="#modalForm">
				</div>
				
				<!-- table -->	
				<div id="display" class="panel-body">
					
				</div>
			
				<!-- footer -->
				<div class="panel-footer">
					
				</div>
			</div>
			
			<!-- footer -->
			<div class="page-footer">
				<p>Copyrigh &copy; Lun Sovathana</p>
			</div>
		</div>
		
		
		<!--modal form-->
        <!--add or update form-->
		<div class="modal fade" id="modalForm">
          <div class="modal-dialog">
            <div class="modal-content">
              <!--modal header-->
               <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Modal title</h4>
              </div><!--end modal header-->
              
              <!--modal body-->
              <div class="modal-body">
               
               <!--message-->
                <div class="bs-example" style="display:none;">
                    <div class="alert alert-danger fade in">
                        <a href="#" class="close" data-dismiss="alert">&times;</a>
                        <strong>Error!</strong> &nbsp;&nbsp; <span class="message"></span>
                    </div>
                </div><!--end message-->
                
                <form id="inputForm" method="post" class="form-horizontal">
                    
                      <div class="form-group">
                        <label class="col-sm-3 control-label">ID</label>
                        <div class="col-sm-5">
                            <input type="text" class="form-control" name="stuId" id="stuId" placeholder="Ex: 131N01" />
                        </div>
                    </div>
                     
                      
                      <div class="form-group">
                        <label class="col-sm-3 control-label">Full name</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" name="firstName" id="firstName" placeholder="First name" />
                        </div>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" name="lastName" id="lastName" placeholder="Last name" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">Gender</label>
                        <div class="col-sm-6">
                            <div class="radio">
                                <label>
                                    <input type="radio" name="gender" value="male" id="male" /> Male
                                </label>
                            </div>
                            <div class="radio">
                                <label>
                                    <input type="radio" name="gender" value="female" id="female" /> Female
                                </label>
                            </div>
                        </div>
                    </div>
                    
                    
                      <div class="form-group">
                        <label class="col-sm-3 control-label">University</label>
                        <div class="col-sm-5">
                            <input type="text" class="form-control" name="stuUniversity" id="stuUniversity" placeholder="Ex: NORTON" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">Class</label>
                        <div class="col-sm-5">
                            <input type="text" class="form-control" name="stuClass" id="stuClass" placeholder="Ex: BTB" />
                        </div>
                    </div>
                      
                    <div class="form-group">
                        <div class="col-sm-9 col-sm-offset-3">
                            <button type="submit" class="btn btn-primary" name="save" id="save" value="Save">Save</button>
                            <button type="reset" class="btn btn-default" name="clear" value="Clear">Clear</button>
                        </div>
                    </div>
                </form>
              </div><!--end modal body-->
              
            </div><!-- /.modal-content -->
          </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->
		<!--end add or update form-->
		
		<!--delete confirmation form-->
		<div class="modal fade" id="modalDelete">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Confirm</h4>
              </div>
              <div class="modal-body">
                  <p>Are you sure want to delete student ID: <span id="confirmId"></span></p>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" id="btnCancel" onclick="clearDelete()">Cancel</button>
                <button type="button" class="btn btn-danger" id="btnDelete" onclick="deleteStudent(this)">Delete</button>
              </div>
            </div><!-- /.modal-content -->
          </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->
		<!--end delete confirmation form-->
		
		<!--end modal form-->
		
		
	</body>
	<script>
		$(document).ready(function(){
			
            // call list to show
            getClassList(); 
			viewStudent(); 
			
			// search
			$('#txt_search').on('input', function(){
				search();
			});
            
            // validate the input form

            $('#inputForm').formValidation({
                message: 'This value is not valid',
                icon: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    firstName: {
                        row: '.col-sm-4',
                        validators: {
                            notEmpty: {
                                message: 'The first name is required'
                            }
                        }
                    },
                    lastName: {
                        row: '.col-sm-4',
                        validators: {
                            notEmpty: {
                                message: 'The last name is required'
                            }
                        }
                    },
                    stuId: {
                        message: 'The ID is not valid',
                        validators: {
                            notEmpty: {
                                message: 'The ID is required'
                            },
                            stringLength: {
                                min: 6,
                                max: 6,
                                message: 'The ID must be 6 characters'
                            },
                            regexp: {
                                regexp: /^[a-zA-Z0-9]+$/,
                                message: 'The ID can only consist of alphabetical and number'
                            }
                        }
                    },
                    stuUniversity: {
                        validators: {
                            notEmpty: {
                                message: 'The university is required'
                            }
                        }
                    },
                    stuClass: {
                        validators: {
                            notEmpty: {
                                message: 'The class is required'
                            },
                            stringLength: {
                                min: 2,
                                max: 5,
                                message: 'The class must be at lease 3 and max is 5 character'
                            }
                        }
                    },
                    gender: {
                        validators: {
                            notEmpty: {
                                message: 'The gender is required'
                            }
                        }
                    }
                }
            }).on('success.form.fv', function(e) {
                // Prevent form submission
                e.preventDefault();

                // Some instances you can use are
                var $form = $(e.target),        // The form instance
                    fv    = $(e.target).data('formValidation'); // FormValidation instance
                
                
                // start process
                if($('#save').val() == 'Save'){
                    // call add function
                    addStudent();
                    
                }else{
                    // call update function
                    updateStudent();
                    
                }
                
            });
            
            // reset form on close
            $('#modalForm').on('hidden.bs.modal', function(e){
                
                // reset form data
                $(this).find('form')[0].reset();
                
                // clear id state
                $('#stuId').removeAttr('disabled');
                
                // clear gender checkstate
                $('#male').removeAttr('checked');
                $('#female').removeAttr('checked');
                
            });
		});
		
	</script>
	
    
    <script src="js/script.js" type="text/javascript"></script>
    
</html>